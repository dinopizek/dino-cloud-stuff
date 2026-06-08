variable "name" {
  type = string
}

variable "settings" {
  description = "(Required) configuration object describing the resource configuration"
  type        = any
}

variable "infrastructure_subnet_id" {
  type    = string
  default = null
}
