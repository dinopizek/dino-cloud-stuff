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

module "delegated_subnet" {
  source     = "../../modules/networking/subnet_delegated"
  for_each   = var.delegated_subnets
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

module "subnet_network_security_group_association" {
  source                    = "../../modules/networking/subnet_network_security_group_association"
  for_each                  = var.subnet_network_security_group_associations
  subnet_id                 = try(module.subnet[each.value.subnet_key].id, module.delegated_subnet[each.value.delegated_subnet_key].id)
  network_security_group_id = module.network_security_group[each.value.network_security_group_key].id
  depends_on                = [module.subnet, module.delegated_subnet, module.network_security_group]
}

module "container_app_environment" {
  source                   = "../../modules/container/container_app_environment"
  for_each                 = var.container_app_environments
  name                     = each.key
  settings                 = each.value
  infrastructure_subnet_id = try(module.subnet[each.value.infrastructure_subnet_key].id, module.delegated_subnet[each.value.infrastructure_subnet_key].id, null)
  depends_on               = [module.resource_group, module.subnet, module.delegated_subnet]
}

module "container_app" {
  source                       = "../../modules/container/container_app"
  for_each                     = var.container_apps
  name                         = each.key
  settings                     = each.value
  container_app_environment_id = module.container_app_environment[each.value.container_app_environment_key].id
  depends_on                   = [module.container_app_environment]
}

module "postgresql_flexible_server" {
  source     = "../../modules/sql/postgresql_flexible_server"
  for_each   = var.postgresql_flexible_servers
  name       = each.key
  settings   = each.value
  tenant_id  = data.azurerm_client_config.current.tenant_id
  depends_on = [module.resource_group]
}

module "service_plan" {
  source     = "../../modules/web/service_plan"
  for_each   = var.service_plans
  name       = each.key
  settings   = each.value
  depends_on = [module.resource_group]
}

module "linux_web_app" {
  source          = "../../modules/web/linux_web_app"
  for_each        = var.linux_web_apps
  name            = each.key
  settings        = each.value
  service_plan_id = module.service_plan[each.value.service_plan_key].id
  depends_on      = [module.resource_group, module.service_plan]
}