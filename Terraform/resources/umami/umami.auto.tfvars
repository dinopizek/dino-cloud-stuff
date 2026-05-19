resource_groups = {
  rg-sc-umami-workload-prod-01 = {
    location = "swedencentral"
    tags = {
      ManagedBy = "Terraform"
    }
  }
  rg-sc-umami-network-prod-01 = {
    location = "swedencentral"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

virtual_networks = {
  vn-sc-umami-prod-01 = {
    address_space       = ["10.0.0.0/16"]
    location            = "swedencentral"
    resource_group_name = "rg-sc-umami-network-prod-01"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

subnets = {
  sn-pe-prod-01 = {
    address_prefixes     = ["10.0.0.0/24"]
    resource_group_name  = "rg-sc-umami-network-prod-01"
    virtual_network_name = "vn-sc-umami-prod-01"
  }
}

delegated_subnets = {
  sn-cae-prod-01 = {
    address_prefixes     = ["10.0.1.0/24"]
    resource_group_name  = "rg-sc-umami-network-prod-01"
    virtual_network_name = "vn-sc-umami-prod-01"
    delegation = {
      name = "container-app-environment-delegation"

      service_delegation = {
        name    = "Microsoft.App/environments"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
    }
  }
}

network_security_groups = {
  nsg-sn-pe-prod-01 = {
    location            = "swedencentral"
    resource_group_name = "rg-sc-umami-network-prod-01"
  }
  nsg-sn-cae-prod-01 = {
    location            = "swedencentral"
    resource_group_name = "rg-sc-umami-network-prod-01"
  }
}

subnet_network_security_group_associations = {
  pe_nsg_association = {
    subnet_key                 = "sn-pe-prod-01"
    network_security_group_key = "nsg-sn-pe-prod-01"
  }
  cae_nsg_association = {
    delegated_subnet_key       = "sn-cae-prod-01"
    network_security_group_key = "nsg-sn-cae-prod-01"
  }
}

container_app_environments = {
  cae-sc-umami-prod-01 = {
    location              = "swedencentral"
    resource_group_name   = "rg-sc-umami-workload-prod-01"
    public_network_access = "Disabled"

    workload_profile = {
      name                  = "Consumption"
      workload_profile_type = "Consumption"
    }
  }
}

container_apps = {
  ca-sc-umami-prod-01 = {
    container_app_environment_key = "cae-sc-umami-prod-01"
    resource_group_name           = "rg-sc-umami-workload-prod-01"
    revision_mode                 = "Multiple"
    workload_profile_name         = "Consumption"

    template = {
      container = {
        name   = "umami-app"
        image  = "ghcr.io/umami-software/umami:latest"
        cpu    = 1
        memory = "2Gi"

        env = {
          name        = "DATABASE_URL"
          secret_name = "umami-connection-string"
        }
      }
      max_replicas = 1
      min_replicas = 1
    }

    ingress = {
      allow_insecure_connections = false
      target_port                = 3000
      transport                  = "auto"
      external_enabled           = true

      traffic_weight = {
        latest_revision = true
        percentage      = 100
      }
    }

    secret = {
      name  = "umami-connection-string"
      value = "postgresql://umami:password@psqldb-sc-umami-prod-01.postgres.database.azure.com/umami?sslmode=verify-full"
    }
  }
}

postgresql_flexible_servers = {
  psqldb-sc-umami-prod-01 = {
    location               = "swedencentral"
    resource_group_name    = "rg-sc-umami-workload-prod-01"
    version                = "18"
    sku_name               = "B_Standard_B1ms"
    administrator_login    = "dbadmin"
    administrator_password = "oEw3UfTmYwBgD4wEnXsAeLAesxqSZO"
    storage_mb             = 65536
    storage_tier           = "P6"

    authentication = {
      active_directory_auth_enabled = true
      password_auth_enabled         = true
    }

    identity = {
      type = "SystemAssigned"
    }
  }
}