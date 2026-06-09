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
  public_ip_address_id = try(module.public_ip[each.value.ip_configuration.public_ip_address_key].id, null)
}

module "windows_virtual_machine" {
  source                = "../../modules/compute/windows_virtual_machine"
  for_each              = var.windows_virtual_machines
  name                  = each.key
  settings              = each.value
  network_interface_ids = [module.network_interface[each.value.network_interface_key].id]
}

module "mssql_virtual_machine" {
  source             = "../../modules/database/mssql_virtual_machine"
  for_each           = var.mssql_virtual_machines
  virtual_machine_id = module.windows_virtual_machine[each.value.vm_key].id
  settings           = each.value
}

module "recovery_services_vault" {
  source     = "../../modules/recovery_services/recovery_services_vault"
  for_each   = var.recovery_services_vaults
  name       = each.key
  settings   = each.value
  depends_on = [module.resource_group]
}

module "backup_policy_vm" {
  source              = "../../modules/recovery_services/backup_policy_vm"
  for_each            = var.backup_policies_vm
  name                = each.key
  settings            = each.value
  resource_group_name = var.recovery_services_vaults[each.value.vault_key].resource_group_name
  recovery_vault_name = each.value.vault_key
  depends_on          = [module.recovery_services_vault]
}

module "backup_protected_vm" {
  source              = "../../modules/recovery_services/backup_protected_vm"
  for_each            = var.backup_protected_vms
  resource_group_name = var.recovery_services_vaults[each.value.vault_key].resource_group_name
  recovery_vault_name = each.value.vault_key
  source_vm_id        = module.windows_virtual_machine[each.value.vm_key].id
  backup_policy_id    = module.backup_policy_vm[each.value.backup_policy_key].id
}
