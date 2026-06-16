resource "azurerm_subnet" "delegated_subnet" {
  name                 = var.name
  resource_group_name  = var.settings.resource_group_name
  virtual_network_name = var.settings.virtual_network_name
  address_prefixes     = var.settings.address_prefixes

  delegation {
    name = try(var.settings.delegation.name, null)

    service_delegation {
      name    = try(var.settings.delegation.service_delegation.name, null)
      actions = try(var.settings.delegation.service_delegation.actions, null)
    }
  }
}