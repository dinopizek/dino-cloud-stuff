resource "azurerm_subnet" "subnet" {
  name                 = var.name
  resource_group_name  = var.settings.resource_group_name
  virtual_network_name = var.settings.virtual_network_name
  address_prefixes     = var.settings.address_prefixes
}