resource "azurerm_bastion_host" "bastion_host" {
  name                = var.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name

  ip_configuration {
    name                 = var.settings.ip_configuration.name
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_address_id
  }
  tags = try(var.settings.tags, null)
}