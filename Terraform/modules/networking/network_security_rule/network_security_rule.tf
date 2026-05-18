resource "azurerm_network_security_rule" "network_security_rule" {
  name                        = var.name
  priority                    = var.settings.priority
  direction                   = var.settings.direction
  access                      = var.settings.access
  protocol                    = var.settings.protocol
  source_port_range           = var.settings.source_port_range
  destination_port_range      = var.settings.destination_port_range
  source_address_prefix       = var.settings.source_address_prefix
  destination_address_prefix  = var.settings.destination_address_prefix
  resource_group_name         = var.settings.resource_group_name
  network_security_group_name = var.settings.network_security_group_name
}