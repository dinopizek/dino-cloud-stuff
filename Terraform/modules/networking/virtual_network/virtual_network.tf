resource "azurerm_virtual_network" "virtual_network" {
  name                = "vn-gewe-k3s-dino-01"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.k3s_resource_group.location
  resource_group_name = azurerm_resource_group.k3s_resource_group.name
}