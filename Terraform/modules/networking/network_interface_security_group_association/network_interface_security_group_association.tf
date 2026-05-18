resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.k3s_network_interface[each.key].id
  network_security_group_id = azurerm_network_security_group.k3s_network_security_group.id
}