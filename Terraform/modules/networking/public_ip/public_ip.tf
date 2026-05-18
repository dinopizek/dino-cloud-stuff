resource "azurerm_public_ip" "k3s_public_ip" {
  name                = "pip-vm-gewe-k3s-${each.key}"
  location            = azurerm_resource_group.k3s_resource_group.location
  resource_group_name = azurerm_resource_group.k3s_resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
}