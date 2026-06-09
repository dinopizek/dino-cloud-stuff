resource "azurerm_mssql_virtual_machine" "mssql_virtual_machine" {
  virtual_machine_id    = var.virtual_machine_id
  sql_license_type      = try(var.settings.sql_license_type, "PAYG")
  sql_connectivity_type = try(var.settings.sql_connectivity_type, "PRIVATE")
  sql_connectivity_port = try(var.settings.sql_connectivity_port, 1433)
  r_services_enabled    = try(var.settings.r_services_enabled, false)
  tags                  = try(var.settings.tags, null)
}
