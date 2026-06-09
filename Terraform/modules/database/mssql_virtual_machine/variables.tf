variable "virtual_machine_id" {
  type = string
}

variable "settings" {
  description = "(Required) configuration object describing the SQL virtual machine configuration"
  type        = any
}
