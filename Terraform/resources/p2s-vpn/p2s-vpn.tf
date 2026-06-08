module "resource_group" {
  source   = "../../modules/resource_group"
  for_each = var.resource_groups
  name     = each.key
  settings = each.value
}

module "virtual_network" {
  source     = "../../modules/networking/virtual_network"
  for_each   = var.virtual_networks
  name       = each.key
  settings   = each.value
  depends_on = [module.resource_group]
}

module "subnet" {
  source     = "../../modules/networking/subnet"
  for_each   = var.subnets
  name       = each.key
  settings   = each.value
  depends_on = [module.virtual_network]
}

module "network_security_group" {
  source     = "../../modules/networking/network_security_group"
  for_each   = var.network_security_groups
  name       = each.key
  settings   = each.value
  depends_on = [module.resource_group]
}

module "network_security_rule" {
  source     = "../../modules/networking/network_security_rule"
  for_each   = var.network_security_rules
  name       = each.key
  settings   = each.value
  depends_on = [module.network_security_group]
}

module "subnet_network_security_group_association" {
  source                    = "../../modules/networking/subnet_network_security_group_association"
  for_each                  = var.subnet_network_security_group_associations
  subnet_id                 = module.subnet[each.value.subnet_key].id
  network_security_group_id = module.network_security_group[each.value.network_security_group_key].id
}

module "route_table" {
  source     = "../../modules/networking/route_table"
  for_each   = var.route_tables
  name       = each.key
  settings   = each.value
  depends_on = [module.resource_group]
}

module "subnet_route_table_association" {
  source         = "../../modules/networking/subnet_route_table_association"
  for_each       = var.subnet_route_table_associations
  subnet_id      = module.subnet[each.value.subnet_key].id
  route_table_id = module.route_table[each.value.route_table_key].id
}

module "public_ip" {
  source     = "../../modules/networking/public_ip"
  for_each   = var.public_ips
  name       = each.key
  settings   = each.value
  zones      = try(each.value.zones, null)
  depends_on = [module.resource_group]
}

module "vpn_gateway" {
  source               = "../../modules/networking/vpn_gateway"
  for_each             = var.vpn_gateways
  name                 = each.key
  settings             = each.value
  subnet_id            = module.subnet[each.value.gateway_subnet_key].id
  public_ip_address_id = module.public_ip[each.value.public_ip_key].id
  aad_tenant           = "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/"
  aad_issuer           = "https://sts.windows.net/${data.azurerm_client_config.current.tenant_id}/"
  depends_on           = [module.resource_group]
}

module "network_interface" {
  source               = "../../modules/networking/network_interface"
  for_each             = var.network_interfaces
  name                 = each.key
  settings             = each.value
  subnet_id            = module.subnet[each.value.ip_configuration.subnet_key].id
  public_ip_address_id = try(module.public_ip[each.value.ip_configuration.public_ip_address_key].id, null)
}

module "linux_virtual_machine" {
  source                = "../../modules/compute/linux_virtual_machine"
  for_each              = var.linux_virtual_machines
  name                  = each.key
  settings              = each.value
  network_interface_ids = [module.network_interface[each.value.network_interface_key].id]
}

module "virtual_network_peering" {
  source                    = "../../modules/networking/virtual_network_peering"
  for_each                  = var.virtual_network_peerings
  name                      = each.key
  settings                  = each.value
  remote_virtual_network_id = module.virtual_network[each.value.remote_virtual_network_key].id
  depends_on                = [module.vpn_gateway]
}
