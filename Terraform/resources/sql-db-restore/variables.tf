variable "resource_groups" {
  type = map(any)
}

variable "virtual_networks" {
  type = map(any)
}

variable "subnets" {
  type = map(any)
}

variable "network_security_groups" {
  type = map(any)
}

variable "network_security_rules" {
  type = map(any)
}

variable "subnet_network_security_group_associations" {
  type = map(any)
}

variable "public_ips" {
  type = map(any)
}

variable "network_interfaces" {
  type = map(any)
}

variable "windows_virtual_machines" {
  type = map(any)
}

variable "mssql_virtual_machines" {
  type = map(any)
}

variable "recovery_services_vaults" {
  type = map(any)
}

variable "backup_policies_vm" {
  type = map(any)
}

variable "backup_protected_vms" {
  type = map(any)
}
