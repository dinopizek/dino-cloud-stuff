data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "conn_data_resource_group" {
  provider = azurerm.connectivity
  for_each = var.conn_data_resource_groups
  name     = each.key
}

data "azurerm_virtual_network" "id_data_virtual_network" {
  provider            = azurerm.identity
  for_each            = var.id_data_virtual_networks
  name                = each.key
  resource_group_name = each.value.resource_group_name
}