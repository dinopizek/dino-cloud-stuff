resource "azurerm_network_interface" "network_interface" {
  name                = var.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  tags                = try(var.settings.tags, null)

  ip_configuration {
    name                          = var.settings.ip_configuration.name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.settings.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = var.public_ip_address_id
  }
}