resource "azurerm_application_gateway" "application_gateway" {
  name                = var.name
  resource_group_name = var.settings.resource_group_name
  location            = var.settings.location

  sku {
    name     = var.settings.sku.name
    tier     = var.settings.sku.tier
    capacity = var.settings.sku.capacity
  }

  gateway_ip_configuration {
    name      = var.settings.gateway_ip_configuration.name
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = var.settings.frontend_port.name
    port = var.settings.frontend_port.port
  }

  frontend_ip_configuration {
    name                 = var.settings.frontend_ip_configuration.name
    public_ip_address_id = var.public_ip_address_id
  }

  backend_address_pool {
    name = var.settings.backend_address_pool.name
  }

  backend_http_settings {
    name                  = var.settings.backend_http_settings.name
    cookie_based_affinity = var.settings.backend_http_settings.cookie_based_affinity
    port                  = var.settings.backend_http_settings.port
    protocol              = var.settings.backend_http_settings.protocol
  }

  http_listener {
    name                           = var.settings.http_listener.name
    frontend_ip_configuration_name = var.settings.http_listener.frontend_ip_configuration_name
    frontend_port_name             = var.settings.http_listener.frontend_port_name
    protocol                       = var.settings.http_listener.protocol
  }

  request_routing_rule {
    name                       = var.settings.request_routing_rule.name
    priority                   = var.settings.request_routing_rule.priority
    rule_type                  = var.settings.request_routing_rule.rule_type
    http_listener_name         = var.settings.request_routing_rule.http_listener_name
    backend_address_pool_name  = var.settings.request_routing_rule.backend_address_pool_name
    backend_http_settings_name = var.settings.request_routing_rule.backend_http_settings_name
  }
  tags = try(var.settings.tags, null)
}