resource "azurerm_subnet" "subnet" {
  name                 = "sn-k3s-dino-01"
  resource_group_name  = azurerm_resource_group.k3s_resource_group.name
  virtual_network_name = azurerm_virtual_network.k3s_virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}