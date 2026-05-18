resource "azurerm_network_interface_security_group_association" "network_interface_security_group_association" {
  network_interface_id      = var.settings.network_interface_id
  network_security_group_id = var.settings.network_security_group_id
}