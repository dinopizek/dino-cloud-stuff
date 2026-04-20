provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "umami_workload_resource_group" {
  name     = "rg-sc-umami-prod-01"
  location = "swedencentral"
  tags = {
    ManagedBy = "Terraform"
  }
}

resource "azurerm_resource_group" "umami_network_resource_group" {
  name     = "rg-sc-umami-network-prod-01"
  location = "swedencentral"
  tags = {
    ManagedBy = "Terraform"
  }
}

resource "azurerm_virtual_network" "umami_virtual_network" {
  name                = "vn-sc-umami-prod-01"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.umami_network_resource_group.location
  resource_group_name = azurerm_resource_group.umami_network_resource_group.name
}

resource "azurerm_subnet" "pe_subnet" {
  name                 = "sn-pe-prod-01"
  resource_group_name  = azurerm_resource_group.umami_network_resource_group.name
  virtual_network_name = azurerm_virtual_network.umami_virtual_network.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "cae_subnet" {
  name                 = "sn-cae-prod-01"
  resource_group_name  = azurerm_resource_group.umami_network_resource_group.name
  virtual_network_name = azurerm_virtual_network.umami_virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "pe_network_security_group" {
  name                = "nsg-sn-pe-prod-01"
  location            = azurerm_resource_group.umami_network_resource_group.location
  resource_group_name = azurerm_resource_group.umami_network_resource_group.name
}

resource "azurerm_network_security_group" "cae_network_security_group" {
  name                = "nsg-sn-cae-prod-01"
  location            = azurerm_resource_group.umami_network_resource_group.location
  resource_group_name = azurerm_resource_group.umami_network_resource_group.name
}

resource "azurerm_subnet_network_security_group_association" "pe_nsg_association" {
  subnet_id                 = azurerm_subnet.pe_subnet.id
  network_security_group_id = azurerm_network_security_group.pe_network_security_group.id
}

resource "azurerm_subnet_network_security_group_association" "cae_nsg_association" {
  subnet_id                 = azurerm_subnet.cae_subnet.id
  network_security_group_id = azurerm_network_security_group.cae_network_security_group.id
}

resource "azurerm_route_table" "umami_route_table" {
  name                = "rt-sc-umami-prod-01"
  location            = azurerm_resource_group.umami_network_resource_group.location
  resource_group_name = azurerm_resource_group.umami_network_resource_group.name
}

resource "azurerm_container_app_environment" "umami_container_app_environment" {
  name                = "cae-sc-umami-prod-01"
  location            = azurerm_resource_group.umami_workload_resource_group.location
  resource_group_name = azurerm_resource_group.umami_workload_resource_group.name

  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
  }
}

resource "azurerm_container_app" "umami_container_app" {
  name                         = "ca-sc-umami-prod-01"
  container_app_environment_id = azurerm_container_app_environment.umami_container_app_environment.id
  resource_group_name          = azurerm_resource_group.umami_workload_resource_group.name
  revision_mode                = "Single"
  workload_profile_name        = "Consumption"

  template {
    container {
      name   = "umami-app"
      image  = "ghcr.io/umami-software/umami:latest"
      cpu    = 1
      memory = "2Gi"

      env {
        name        = "DATABASE_URL"
        secret_name = "umami-connection-string"
      }
    }
    max_replicas = 1
    min_replicas = 1
  }

  ingress {
    allow_insecure_connections = false
    target_port                = 3000
    transport                  = "auto"
    external_enabled           = true

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  secret {
    name  = "umami-connection-string"
    value = "postgresql://umami:password@psqldb-sc-umami-prod-01.postgres.database.azure.com/umami?sslmode=verify-full"
  }
}

data "azurerm_client_config" "current" {}

data "azuread_user" "admin" {
  user_principal_name = "dino@rnr.hr"
}

resource "azurerm_postgresql_flexible_server" "umami_postgresql_server" {
  name                   = "psqldb-sc-umami-prod-01"
  location               = azurerm_resource_group.umami_workload_resource_group.location
  resource_group_name    = azurerm_resource_group.umami_workload_resource_group.name
  version                = "18"
  sku_name               = "B_Standard_B1ms"
  administrator_login    = "dbadmin"
  administrator_password = "oEw3UfTmYwBgD4wEnXsAeLAesxqSZO"
  storage_mb             = 65536
  storage_tier           = "P6"

  authentication {
    active_directory_auth_enabled = true
    tenant_id                     = data.azurerm_client_config.current.tenant_id
    password_auth_enabled         = true
  }

  lifecycle {
    ignore_changes = [zone]
  }
}

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "postgresql_administrator" {
  server_name         = azurerm_postgresql_flexible_server.umami_postgresql_server.name
  resource_group_name = azurerm_resource_group.umami_workload_resource_group.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azuread_user.admin.object_id
  principal_name      = data.azuread_user.admin.user_principal_name
  principal_type      = "User"
}