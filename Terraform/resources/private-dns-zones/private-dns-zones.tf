module "private_dns_zone" {
  source   = "../../modules/networking/private_dns_zone"
  for_each = var.private_dns_zones
  settings = each.value
}

module "private_dns_zone_virtual_network_link" {
  source              = "../../modules/networking/private_dns_zone_virtual_network_link"
  for_each            = var.private_dns_zone_virtual_network_links
  name                = each.key
  settings            = each.value
  private_dns_zone_id = module.private_dns_zone[each.value.private_dns_zone_key].id
  virtual_network_id  = data.azurerm_virtual_network.id_data_virtual_network[each.value.virtual_network_key].id
  depends_on          = [module.private_dns_zone]
}