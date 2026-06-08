resource "azurerm_route_table" "route_table" {
  name                          = var.name
  location                      = var.settings.location
  resource_group_name           = var.settings.resource_group_name
  bgp_route_propagation_enabled = try(var.settings.bgp_route_propagation_enabled, true)
  tags                          = try(var.settings.tags, null)

  dynamic "route" {
    for_each = try(var.settings.routes, [])
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = try(route.value.next_hop_in_ip_address, null)
    }
  }
}
