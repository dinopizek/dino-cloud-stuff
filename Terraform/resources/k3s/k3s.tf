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

module "public_ip" {
  source     = "../../modules/networking/public_ip"
  for_each   = var.public_ips
  name       = each.key
  settings   = each.value
  depends_on = [module.resource_group]
}

module "network_interface" {
  source               = "../../modules/networking/network_interface"
  for_each             = var.network_interfaces
  name                 = each.key
  settings             = each.value
  subnet_id            = module.subnet[each.value.ip_configuration.subnet_key].id
  public_ip_address_id = module.public_ip[each.value.ip_configuration.public_ip_address_key].id
  depends_on           = [module.subnet, module.network_security_group, module.public_ip]
}

module "network_security_group_association" {
  source                    = "../../modules/networking/network_interface_security_group_association"
  for_each                  = var.network_security_group_associations
  network_interface_id      = module.network_interface[each.value.network_interface_key].id
  network_security_group_id = module.network_security_group[each.value.network_security_group_key].id
  depends_on                = [module.network_interface, module.network_security_group]
}