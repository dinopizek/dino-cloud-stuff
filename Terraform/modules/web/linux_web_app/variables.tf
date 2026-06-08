variable "name" {
  type = string
}

variable "settings" {
  description = "(Required) configuration object describing the resource configuration"
  type        = any
}

variable "service_plan_id" {
  type = string
}
