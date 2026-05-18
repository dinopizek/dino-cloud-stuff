resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
  name                   = var.name
  location               = var.settings.location
  resource_group_name    = var.settings.resource_group_name
  version                = var.settings.version
  sku_name               = var.settings.sku_name
  administrator_login    = var.settings.administrator_login
  administrator_password = var.settings.administrator_password
  storage_mb             = var.settings.storage_mb
  storage_tier           = var.settings.storage_tier

  identity {
    type = var.settings.identity.type
  }

  authentication {
    active_directory_auth_enabled = var.settings.authentication.active_directory_auth_enabled
    tenant_id                     = var.tenant_id
    password_auth_enabled         = var.settings.authentication.password_auth_enabled
  }

  lifecycle {
    ignore_changes = [zone]
  }
}