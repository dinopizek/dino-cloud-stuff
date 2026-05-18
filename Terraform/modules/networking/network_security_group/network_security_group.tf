resource "azurerm_network_security_group" "k3s_network_security_group" {
  name                = "nsg-vn-gewe-k3s-dino-01"
  location            = azurerm_resource_group.k3s_resource_group.location
  resource_group_name = azurerm_resource_group.k3s_resource_group.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "195.20.153.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "k3s-api"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "6443"
    source_address_prefix      = "195.20.153.0/24"
    destination_address_prefix = "*"
  }
}