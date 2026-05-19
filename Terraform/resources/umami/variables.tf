variable "resource_groups" {
  type = map(any)
}

variable "virtual_networks" {
  type = map(any)
}

variable "subnets" {
  type = map(any)
}

variable "delegated_subnets" {
  type = map(any)
}

variable "network_security_groups" {
  type = map(any)
}

variable "subnet_network_security_group_associations" {
  type = map(any)
}

variable "container_app_environments" {
  type = map(any)
}

variable "container_apps" {
  type = map(any)
}

variable "postgresql_flexible_servers" {
  type = map(any)
}

variable "service_plans" {
  type = map(any)
}

variable "linux_web_apps" {
  type = map(any)
}