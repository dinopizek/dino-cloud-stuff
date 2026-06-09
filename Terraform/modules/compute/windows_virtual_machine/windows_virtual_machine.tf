resource "azurerm_windows_virtual_machine" "windows_virtual_machine" {
  name                  = var.name
  resource_group_name   = var.settings.resource_group_name
  location              = var.settings.location
  size                  = var.settings.size
  admin_username        = var.settings.admin_username
  admin_password        = var.settings.admin_password
  computer_name         = try(var.settings.computer_name, null)
  network_interface_ids = var.network_interface_ids
  tags                  = try(var.settings.tags, null)

  os_disk {
    name                 = var.settings.os_disk.name
    caching              = var.settings.os_disk.caching
    storage_account_type = var.settings.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.settings.source_image_reference.publisher
    offer     = var.settings.source_image_reference.offer
    sku       = var.settings.source_image_reference.sku
    version   = var.settings.source_image_reference.version
  }
}
