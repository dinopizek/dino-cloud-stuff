resource "azurerm_managed_disk" "managed_disk" {
  name                 = var.name
  location             = var.settings.location
  resource_group_name  = var.settings.resource_group_name
  storage_account_type = var.settings.storage_account_type
  create_option        = var.settings.create_option
  disk_size_gb         = var.settings.disk_size_gb
  zone                 = try(var.settings.zone, null)
  tags                 = try(var.settings.tags, null)
}