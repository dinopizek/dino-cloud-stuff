resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  lifecycle {
    ignore_changes = [tags]
  }
  name                = var.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  tags                = try(var.settings.tags, null)
}