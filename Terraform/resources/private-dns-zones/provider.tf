provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  subscription_id = var.CONN_SUBSCRIPTION_ID
  alias           = "connectivity"
}

provider "azurerm" {
  features {}
  subscription_id = var.IDENTITY_SUBSCRIPTION_ID
  alias           = "identity"
}