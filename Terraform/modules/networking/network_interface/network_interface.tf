resource "azurerm_network_interface" "network_interface" {
  name                = var.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name

  ip_configuration {
    name                          = var.settings.ip_configuration.name
    subnet_id                     = var.settings.ip_configuration.subnet_id
    private_ip_address_allocation = var.settings.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = var.settings.ip_configuration.public_ip_address_id
  }
}