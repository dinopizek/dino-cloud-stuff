variable "name" {
  type = string
}

variable "settings" {
  description = "(Required) configuration object describing the backup policy configuration"
  type        = any
}

variable "resource_group_name" {
  type = string
}

variable "recovery_vault_name" {
  type = string
}
