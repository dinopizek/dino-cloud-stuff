resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  name                = var.name
  private_dns_zone_id = var.private_dns_zone_id
  virtual_network_id  = var.virtual_network_id
  resolution_policy   = try(var.settings.resolution_policy, "NxDomainRedirect")
}