variable "name" {
  type = string
}

variable "settings" {
  description = "(Required) configuration object describing the resource configuration"
  type        = any
}

variable "tenant_id" {
  type = string
}
