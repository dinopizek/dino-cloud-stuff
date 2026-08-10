resource "azurerm_disk_encryption_set" "disk_encryption_set" {
  lifecycle {
    ignore_changes = [tags]
  }
  name                = var.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  key_vault_key_id    = var.key_vault_key_id

  dynamic "identity" {
    for_each = lookup(var.settings, "identity", false) == false ? [] : [1]

    content {
      type         = var.settings.identity.type
      identity_ids = var.identity_ids
    }
  }
}