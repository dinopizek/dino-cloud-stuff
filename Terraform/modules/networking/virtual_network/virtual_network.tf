resource "azurerm_virtual_network" "virtual_network" {
  name                = var.name
  address_space       = var.settings.address_space
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  tags                = try(var.settings.tags, null)
}