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