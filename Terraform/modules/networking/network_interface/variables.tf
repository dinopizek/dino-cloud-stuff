variable "name" {
  type = string
}

variable "settings" {
  description = "(Required) configuration object describing the resource configuration"
  type        = any
}

variable "subnet_id" {
  type = string
}

variable "public_ip_address_id" {
  type = string
}
