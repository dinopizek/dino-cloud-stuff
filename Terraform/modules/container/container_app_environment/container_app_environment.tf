resource "azurerm_container_app_environment" "container_app_environment" {
  name                               = var.name
  location                           = var.settings.location
  resource_group_name                = var.settings.resource_group_name
  public_network_access              = var.settings.public_network_access
  infrastructure_resource_group_name = try(var.settings.infrastructure_resource_group_name, null)
  infrastructure_subnet_id           = try(var.infrastructure_subnet_id, null)
  internal_load_balancer_enabled     = try(var.settings.internal_load_balancer_enabled, null)

  workload_profile {
    name                  = var.settings.workload_profile.name
    workload_profile_type = var.settings.workload_profile.workload_profile_type
  }
}