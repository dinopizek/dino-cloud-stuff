resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                                    = var.name
  location                                = var.settings.location
  resource_group_name                     = var.settings.resource_group_name
  sku                                     = var.settings.sku
  retention_in_days                       = var.settings.retention_in_days
  immediate_data_purge_on_30_days_enabled = try(var.settings.immediate_data_purge_on_30_days_enabled, null)
  tags                                    = try(var.settings.tags, null)
}