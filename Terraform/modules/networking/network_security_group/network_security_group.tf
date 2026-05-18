resource "azurerm_network_security_group" "network_security_group" {
  name                = var.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  tags                = try(var.settings.tags, null)
}