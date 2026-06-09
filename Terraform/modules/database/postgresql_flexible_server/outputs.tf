output "id" {
  description = "The PostgreSQL flexible server ID."
  value       = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
}

output "identity" {
  description = "The PostgreSQL flexible server identity."
  value       = azurerm_postgresql_flexible_server.postgresql_flexible_server.identity
}