resource "azurerm_kubernetes_cluster_node_pool" "aks_node_pool" {
  lifecycle {
    ignore_changes = [tags, node_count, upgrade_settings]
    #ignore_changes = all
  }
  name                   = var.name
  kubernetes_cluster_id  = var.kubernetes_cluster_id
  vm_size                = var.settings.vm_size
  max_pods               = try(var.settings.max_pods, null)
  os_disk_size_gb        = try(var.settings.os_disk_size_gb, null)
  node_count             = try(var.settings.node_count, null)
  vnet_subnet_id         = try(var.vnet_subnet_id, null)
  node_public_ip_enabled = try(var.settings.node_public_ip_enabled, false)
  max_count              = try(var.settings.max_count, null)
  min_count              = try(var.settings.min_count, null)
  auto_scaling_enabled   = try(var.settings.auto_scaling_enabled, null)
  zones                  = try(var.settings.zones, null)
  node_taints            = try(var.settings.node_taints, null)
  node_labels            = try(var.settings.node_labels, null)
  mode                   = try(var.settings.mode, null)
}