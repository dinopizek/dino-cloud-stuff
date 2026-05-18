resource "azurerm_linux_virtual_machine" "virtual_machine" {
  name                            = "vm-gewe-k3s-${each.key}"
  resource_group_name             = azurerm_resource_group.k3s_resource_group.name
  location                        = azurerm_resource_group.k3s_resource_group.location
  size                            = "Standard_B1s"
  admin_username                  = "azureuser"
  admin_password                  = "Jakalozinka!"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.k3s_network_interface[each.key].id,
  ]

  os_disk {
    name                 = "osdisk-vm-gewe-k3s-${each.key}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}