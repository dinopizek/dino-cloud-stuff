resource "azurerm_network_watcher" "network_watcher" {
  name                = var.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  tags                = try(var.settings.tags, null)
}