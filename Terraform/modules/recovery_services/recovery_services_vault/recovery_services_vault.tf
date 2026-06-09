resource "azurerm_recovery_services_vault" "recovery_services_vault" {
  name                = var.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  sku                 = var.settings.sku
  tags                = try(var.settings.tags, null)
}
