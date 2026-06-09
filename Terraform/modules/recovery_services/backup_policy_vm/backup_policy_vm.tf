resource "azurerm_backup_policy_vm" "backup_policy_vm" {
  name                           = var.name
  resource_group_name            = var.resource_group_name
  recovery_vault_name            = var.recovery_vault_name
  timezone                       = try(var.settings.timezone, "UTC")
  instant_restore_retention_days = try(var.settings.instant_restore_retention_days, null)

  backup {
    frequency = var.settings.backup.frequency
    time      = var.settings.backup.time
    weekdays  = try(var.settings.backup.weekdays, null)
  }

  dynamic "retention_daily" {
    for_each = try([var.settings.retention_daily], [])
    content {
      count = retention_daily.value.count
    }
  }

  dynamic "retention_weekly" {
    for_each = try([var.settings.retention_weekly], [])
    content {
      count    = retention_weekly.value.count
      weekdays = retention_weekly.value.weekdays
    }
  }
}
