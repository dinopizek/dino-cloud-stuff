resource "azurerm_kubernetes_cluster" "aks" {
  lifecycle {
    ignore_changes = [tags, oms_agent.0.msi_auth_for_monitoring_enabled, default_node_pool.0.upgrade_settings, maintenance_window_node_os]
  }
  name                                = var.name
  location                            = var.settings.location
  resource_group_name                 = var.settings.resource_group_name
  sku_tier                            = try(var.settings.sku_tier)
  support_plan                        = try(var.settings.support_plan, null)
  node_resource_group                 = try(var.settings.node_resource_group)
  private_cluster_enabled             = try(var.settings.private_cluster_enabled, null)
  private_dns_zone_id                 = try(var.private_dns_zone_id, null)
  private_cluster_public_fqdn_enabled = try(var.settings.private_cluster_public_fqdn_enabled, null)
  dns_prefix                          = try(var.settings.dns_prefix, null)
  dns_prefix_private_cluster          = try(var.settings.dns_prefix_private_cluster, null)
  kubernetes_version                  = try(var.settings.kubernetes_version, null)
  image_cleaner_interval_hours        = try(var.settings.image_cleaner_interval_hours, null)
  role_based_access_control_enabled   = try(var.settings.role_based_access_control_enabled, true)
  local_account_disabled              = try(var.settings.local_account_disabled, false)
  oidc_issuer_enabled                 = try(var.settings.oidc_issuer_enabled, true)
  workload_identity_enabled           = try(var.settings.workload_identity_enabled, true)
  azure_policy_enabled                = try(var.settings.azure_policy_enabled, false)
  run_command_enabled                 = try(var.settings.run_command_enabled, true)
  node_os_upgrade_channel             = try(var.settings.node_os_upgrade_channel, null)
  cost_analysis_enabled               = try(var.settings.cost_analysis_enabled, null)
  default_node_pool {
    name            = var.settings.default_node_pool.name
    vm_size         = var.settings.default_node_pool.vm_size
    max_pods        = try(var.settings.default_node_pool.max_pods, null)
    os_disk_size_gb = try(var.settings.default_node_pool.os_disk_size_gb, null)
    node_count      = try(var.settings.default_node_pool.node_count, 1)
    //pod_subnet_id  = try(var.pod_subnet_id, null)
    vnet_subnet_id              = try(var.vnet_subnet_id, null)
    temporary_name_for_rotation = try(var.settings.default_node_pool.temporary_name_for_rotation, false)
    node_public_ip_enabled      = try(var.settings.default_node_pool.node_public_ip_enabled, false)
    max_count                   = try(var.settings.default_node_pool.max_count, null)
    min_count                   = try(var.settings.default_node_pool.min_count, null)
    auto_scaling_enabled        = try(var.settings.default_node_pool.auto_scaling_enabled, null)
    zones                       = try(var.settings.default_node_pool.zones, null)
  }

  node_provisioning_profile {
    mode               = try(var.settings.node_provisioning_profile.mode, "Manual")
    default_node_pools = try(var.settings.node_provisioning_profile.default_node_pools, "Auto")
  }

  network_profile {
    network_plugin      = var.settings.network_profile.network_plugin
    network_plugin_mode = try(var.settings.network_profile.network_plugin_mode, null)
    outbound_type       = try(var.settings.network_profile.outbound_type, null)
    load_balancer_sku   = try(var.settings.network_profile.load_balancer_sku, null)
    dynamic "load_balancer_profile" {
      for_each = lookup(var.settings.network_profile, "load_balancer_profile", false) == false ? [] : [1]
      content {}
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = lookup(var.settings, "azure_active_directory_role_based_access_control", false) == false ? [] : [1]
    content {
      #managed                = var.settings.azure_active_directory_role_based_access_control.managed
      admin_group_object_ids = try(var.admin_group_object_ids, null)
      azure_rbac_enabled     = try(var.settings.azure_active_directory_role_based_access_control.azure_rbac_enabled, null)
    }
  }

  dynamic "maintenance_window_auto_upgrade" {
    for_each = lookup(var.settings, "maintenance_window_auto_upgrade", false) == false ? [] : [1]
    content {
      frequency    = try(var.settings.maintenance_window_auto_upgrade.frequency, null)
      interval     = try(var.settings.maintenance_window_auto_upgrade.interval, null)
      duration     = try(var.settings.maintenance_window_auto_upgrade.duration, null)
      day_of_month = try(var.settings.maintenance_window_auto_upgrade.day_of_month, null)
      day_of_week  = try(var.settings.maintenance_window_auto_upgrade.day_of_week, null)
      start_date   = try(var.settings.maintenance_window_auto_upgrade.start_date, null)
      start_time   = try(var.settings.maintenance_window_auto_upgrade.start_time, null)
      utc_offset   = try(var.settings.maintenance_window_auto_upgrade.utc_offset, null)
    }
  }

  dynamic "identity" {
    for_each = lookup(var.settings, "identity", false) == false ? [] : [1]
    content {
      type         = var.settings.identity.type
      identity_ids = var.identity_ids
    }
  }

  dynamic "kubelet_identity" {
    for_each = lookup(var.settings, "kubelet_identity", false) == false ? [] : [1]
    content {
      client_id                 = var.client_id
      object_id                 = var.object_id
      user_assigned_identity_id = var.user_assigned_identity_id
    }
  }

  dynamic "key_management_service" {
    for_each = lookup(var.settings, "key_management_service", false) == false ? [] : [1]
    content {
      key_vault_key_id         = var.key_vault_key_id
      key_vault_network_access = try(var.settings.key_management_service.key_vault_network_access, null)
    }
  }

  dynamic "oms_agent" {
    for_each = lookup(var.settings, "oms_agent", false) == false ? [] : [1]
    content {
      log_analytics_workspace_id      = var.log_analytics_workspace_id
      msi_auth_for_monitoring_enabled = try(var.settings.oms_agent.msi_auth_for_monitoring_enabled, null)
    }
  }
  tags = try(var.settings.tags, null)
}
