resource "azurerm_private_endpoint" "example" {
  name                = var.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  subnet_id           = var.settings.subnet_id

  private_service_connection {
    name                           = var.settings.private_service_connection.name
    private_connection_resource_id = var.settings.private_service_connection.private_connection_resource_id
    is_manual_connection           = var.settings.private_service_connection.is_manual_connection
  }
}