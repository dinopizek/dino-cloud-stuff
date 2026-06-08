data "azurerm_client_config" "current" {}

data "azuread_user" "dino_user" {
  user_principal_name = "dpizek_span.eu#EXT#@83zivko.onmicrosoft.com"
}