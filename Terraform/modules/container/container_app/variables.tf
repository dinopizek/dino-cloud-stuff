variable "name" {
  type = string
}

variable "settings" {
  description = "(Required) configuration object describing the resource configuration"
  type        = any
}

variable "container_app_environment_id" {
  type = string
}
