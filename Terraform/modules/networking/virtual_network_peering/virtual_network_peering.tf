resource "azurerm_virtual_network_peering" "virtual_network_peering" {
  name                         = var.name
  resource_group_name          = var.settings.resource_group_name
  virtual_network_name         = var.settings.virtual_network_name
  remote_virtual_network_id    = var.remote_virtual_network_id
  allow_virtual_network_access = try(var.settings.allow_virtual_network_access, true)
  allow_forwarded_traffic      = try(var.settings.allow_forwarded_traffic, false)
  allow_gateway_transit        = try(var.settings.allow_gateway_transit, false)
  use_remote_gateways          = try(var.settings.use_remote_gateways, false)
}
