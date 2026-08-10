resource "azurerm_role_assignment" "ra" {
  scope                = var.scope_id
  role_definition_name = var.settings.role_definition_name
  principal_id         = var.principal_id
}