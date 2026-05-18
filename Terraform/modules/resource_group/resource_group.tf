resource "azurerm_resource_group" "resource_group" {
  name     = var.name
  location = var.settings.location
  tags     = try(var.settings.tags, null)
}