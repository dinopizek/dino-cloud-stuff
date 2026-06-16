resource "azurerm_nat_gateway" "nat_gateway" {
  name                = var.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  sku_name            = var.settings.sku_name
  tags                = try(var.settings.tags, null)
}