variable "name" {
  type = string
}

variable "settings" {
  description = "(Required) configuration object describing the networking configuration"
}

variable "private_dns_zone_id" {
  type = string
}

variable "virtual_network_id" {
  type = string
}