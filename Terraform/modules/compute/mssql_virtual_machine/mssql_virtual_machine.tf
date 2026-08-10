resource "azurerm_mssql_virtual_machine" "mssql_virtual_machine" {
  virtual_machine_id               = var.virtual_machine_id
  sql_license_type                 = var.settings.sql_license_type
  r_services_enabled               = var.settings.r_services_enabled
  sql_connectivity_port            = var.settings.sql_connectivity_port
  sql_connectivity_type            = var.settings.sql_connectivity_type
  sql_connectivity_update_password = try(var.settings.sql_connectivity_update_password, null)
  sql_connectivity_update_username = try(var.settings.sql_connectivity_update_username, null)

  sql_instance {
    collation                            = try(var.settings.sql_instance.collation, null)
    instant_file_initialization_enabled  = try(var.settings.sql_instance.instant_file_initialization_enabled, null)
    adhoc_workloads_optimization_enabled = try(var.settings.sql_instance.adhoc_workloads_optimization_enabled, null)
    max_dop                              = try(var.settings.sql_instance.max_dop, null)
    max_server_memory_mb                 = try(var.settings.sql_instance.max_server_memory_mb, null)
    min_server_memory_mb                 = try(var.settings.sql_instance.min_server_memory_mb, null)
    lock_pages_in_memory_enabled         = try(var.settings.sql_instance.lock_pages_in_memory_enabled, null)
  }

  storage_configuration {
    disk_type                      = try(var.settings.storage_configuration.disk_type, null)
    storage_workload_type          = try(var.settings.storage_configuration.storage_workload_type, null)
    system_db_on_data_disk_enabled = try(var.settings.storage_configuration.system_db_on_data_disk_enabled, null)

    data_settings {
      default_file_path = try(var.settings.storage_configuration.data_settings.default_file_path, null)
      luns              = try(var.settings.storage_configuration.data_settings.luns, null)
    }

    log_settings {
      default_file_path = try(var.settings.storage_configuration.log_settings.default_file_path, null)
      luns              = try(var.settings.storage_configuration.log_settings.luns, null)
    }

    temp_db_settings {
      default_file_path = try(var.settings.storage_configuration.temp_db_settings.default_file_path, null)
      luns              = try(var.settings.storage_configuration.temp_db_settings.luns, null)
    }
  }
  tags = try(var.settings.tags, null)
}