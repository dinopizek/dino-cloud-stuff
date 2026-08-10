resource "azurerm_storage_account" "storage_account" {
  lifecycle {
    ignore_changes = [tags]
  }
  name                             = var.name
  resource_group_name              = var.settings.resource_group_name
  location                         = var.settings.location
  account_kind                     = try(var.settings.account_kind, "StorageV2")
  account_tier                     = var.settings.account_tier
  account_replication_type         = var.settings.account_replication_type
  cross_tenant_replication_enabled = try(var.settings.cross_tenant_replication_enabled, true)
  access_tier                      = try(var.settings.access_tier, "Hot")
  edge_zone                        = try(var.settings.edge_zone, null)
  #enable_https_traffic_only         = try(var.settings.enable_https_traffic_only, true)
  https_traffic_only_enabled        = try(var.settings.https_traffic_only_enabled, true)
  min_tls_version                   = try(var.settings.min_tls_version, "TLS1_2")
  allow_nested_items_to_be_public   = try(var.settings.allow_nested_items_to_be_public, true)
  shared_access_key_enabled         = try(var.settings.shared_access_key_enabled, true)
  public_network_access_enabled     = try(var.settings.public_network_access_enabled, true)
  default_to_oauth_authentication   = try(var.settings.default_to_oauth_authentication, false)
  is_hns_enabled                    = try(var.settings.is_hns_enabled, null)
  nfsv3_enabled                     = try(var.settings.nfsv3_enabled, false)
  large_file_share_enabled          = try(var.settings.large_file_share_enabled, null)
  queue_encryption_key_type         = try(var.settings.queue_encryption_key_type, null)
  table_encryption_key_type         = try(var.settings.table_encryption_key_type, null)
  infrastructure_encryption_enabled = try(var.settings.infrastructure_encryption_enabled, null)
  #immutability_policy               = try(var.settings.immutability_policy, null) - DEFINE BLOCK
  #sas_policy                        = try(var.settings.sas_policy, null)  - DEFINE BLOCK
  allowed_copy_scope = try(var.settings.allowed_copy_scope, null)
  sftp_enabled       = try(var.settings.sftp_enabled, null)
  tags               = try(var.settings.tags, null)

  dynamic "customer_managed_key" {
    for_each = lookup(var.settings, "customer_managed_key", false) == false ? [] : [1]
    content {
      key_vault_key_id          = var.cmk_key_vault_key_id
      user_assigned_identity_id = var.cmk_user_assigned_identity_id
    }
  }

  dynamic "share_properties" {
    for_each = lookup(var.settings, "share_properties", false) == false ? [] : [1]
    content {
      retention_policy {
        days = try(var.settings.share_properties.retention_policy.days, null)
      }
    }
  }

  dynamic "custom_domain" {
    for_each = lookup(var.settings, "custom_domain", false) == false ? [] : [1]

    content {
      name          = var.settings.custom_domain.name
      use_subdomain = try(var.settings.custom_domain.use_subdomain, null)
    }
  }

  dynamic "identity" {
    for_each = lookup(var.settings, "identity", false) == false ? [] : [1]

    content {
      type         = var.settings.identity.type
      identity_ids = var.identity_ids
    }
  }

  dynamic "blob_properties" {
    for_each = lookup(var.settings, "blob_properties", false) == false ? [] : [1]

    content {
      versioning_enabled       = try(var.settings.blob_properties.versioning_enabled, false)
      change_feed_enabled      = try(var.settings.blob_properties.change_feed_enabled, false)
      default_service_version  = try(var.settings.blob_properties.default_service_version, "2020-06-12")
      last_access_time_enabled = try(var.settings.blob_properties.last_access_time_enabled, false)

      dynamic "cors_rule" {
        for_each = lookup(var.settings.blob_properties, "cors_rule", false) == false ? [] : [1]

        content {
          allowed_headers    = var.settings.blob_properties.cors_rule.allowed_headers
          allowed_methods    = var.settings.blob_properties.cors_rule.allowed_methods
          allowed_origins    = var.settings.blob_properties.cors_rule.allowed_origins
          exposed_headers    = var.settings.blob_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.settings.blob_properties.cors_rule.max_age_in_seconds
        }
      }

      dynamic "delete_retention_policy" {
        for_each = lookup(var.settings.blob_properties, "delete_retention_policy", false) == false ? [] : [1]

        content {
          days = try(var.settings.blob_properties.delete_retention_policy.delete_retention_policy, 7)
        }
      }

      dynamic "container_delete_retention_policy" {
        for_each = lookup(var.settings.blob_properties, "container_delete_retention_policy", false) == false ? [] : [1]

        content {
          days = try(var.settings.blob_properties.container_delete_retention_policy.container_delete_retention_policy, 7)
        }
      }
    }
  }

  dynamic "network_rules" {
    for_each = lookup(var.settings, "network_rules", null) == null ? [] : [1]
    content {
      bypass                     = try(var.settings.network_rules.bypass, [])
      default_action             = try(var.settings.network_rules.default_action, "Deny")
      ip_rules                   = try(var.settings.network_rules.ip_rules, [])
      virtual_network_subnet_ids = try(var.settings.network_rules.subnets_ids, [])
    }
  }

  dynamic "azure_files_authentication" {
    for_each = lookup(var.settings, "azure_files_authentication", false) == false ? [] : [1]

    content {
      directory_type = var.settings.azure_files_authentication.directory_type

      dynamic "active_directory" {
        for_each = lookup(var.settings.azure_files_authentication, "active_directory", false) == false ? [] : [1]

        content {
          storage_sid         = var.settings.azure_files_authentication.active_directory.storage_sid
          domain_name         = var.settings.azure_files_authentication.active_directory.domain_name
          domain_sid          = var.settings.azure_files_authentication.active_directory.domain_sid
          domain_guid         = var.settings.azure_files_authentication.active_directory.domain_guid
          forest_name         = var.settings.azure_files_authentication.active_directory.forest_name
          netbios_domain_name = var.settings.azure_files_authentication.active_directory.netbios_domain_name
        }
      }
    }
  }

  dynamic "routing" {
    for_each = lookup(var.settings, "routing", false) == false ? [] : [1]

    content {
      publish_internet_endpoints  = try(var.settings.routing.publish_internet_endpoints, false)
      publish_microsoft_endpoints = try(var.settings.routing.publish_microsoft_endpoints, false)
      choice                      = try(var.settings.routing.choice, "MicrosoftRouting")
    }
  }
}