resource "azurerm_public_ip" "public_ip" {
  name                = var.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  allocation_method   = var.settings.allocation_method
  sku                 = var.settings.sku
  zones               = try(var.zones, null)
  tags                = try(var.settings.tags, null)
}