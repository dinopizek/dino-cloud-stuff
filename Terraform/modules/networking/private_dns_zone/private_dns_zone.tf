resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.settings.name
  resource_group_name = var.settings.resource_group_name
  tags                = try(var.settings.tags, null)
}