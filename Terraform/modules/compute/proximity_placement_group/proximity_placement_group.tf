resource "azurerm_proximity_placement_group" "ppg" {
  lifecycle {
    ignore_changes = [tags, zone]
  }
  name                = var.name
  resource_group_name = var.settings.resource_group_name
  location            = var.settings.location
  allowed_vm_sizes    = try(var.settings.allowed_vm_sizes, null)
  zone                = try(var.settings.zone, null)
}