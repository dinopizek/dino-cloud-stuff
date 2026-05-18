resource "azurerm_resource_group" "resource_group" {
  name     = var.name
  location = var.settings.location
  tags     = var.settings.tags
}