resource "azurerm_network_interface" "k3s_network_interface" {
  name                = "nic-vm-gewe-k3s-${each.key}"
  location            = azurerm_resource_group.k3s_resource_group.location
  resource_group_name = azurerm_resource_group.k3s_resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.k3s_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.k3s_public_ip[each.key].id
  }
}