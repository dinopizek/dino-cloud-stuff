resource "azurerm_container_app" "container_app" {
  name                         = var.name
  container_app_environment_id = var.container_app_environment_id
  resource_group_name          = var.settings.resource_group_name
  revision_mode                = var.settings.revision_mode
  workload_profile_name        = var.settings.workload_profile_name

  template {
    container {
      name   = var.settings.template.container.name
      image  = var.settings.template.container.image
      cpu    = var.settings.template.container.cpu
      memory = var.settings.template.container.memory

      env {
        name        = var.settings.template.container.env.name
        secret_name = var.settings.template.container.env.secret_name
      }
    }
    max_replicas = var.settings.template.max_replicas
    min_replicas = var.settings.template.min_replicas
  }

  ingress {
    allow_insecure_connections = var.settings.ingress.allow_insecure_connections
    target_port                = var.settings.ingress.target_port
    transport                  = var.settings.ingress.transport
    external_enabled           = var.settings.ingress.external_enabled

    traffic_weight {
      latest_revision = var.settings.ingress.traffic_weight.latest_revision
      percentage      = var.settings.ingress.traffic_weight.percentage
    }
  }

  secret {
    name  = var.settings.secret.name
    value = var.settings.secret.value
  }
}