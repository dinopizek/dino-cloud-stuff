resource "azurerm_linux_web_app" "linux_web_app" {
  name                = var.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  service_plan_id     = var.service_plan_id

  site_config {
    always_on = var.settings.site_config.always_on
  }
}