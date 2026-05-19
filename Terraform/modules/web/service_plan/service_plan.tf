resource "azurerm_service_plan" "service_plan" {
  name                = var.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  os_type             = var.settings.os_type
  sku_name            = var.settings.sku_name
}