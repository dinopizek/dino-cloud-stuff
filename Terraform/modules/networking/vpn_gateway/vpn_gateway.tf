resource "azurerm_virtual_network_gateway" "vpn_gateway" {
  name                = var.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = var.settings.sku
  active_active       = false
  tags                = try(var.settings.tags, null)

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = var.public_ip_address_id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }

  vpn_client_configuration {
    address_space        = var.settings.vpn_client_configuration.address_space
    vpn_auth_types       = ["AAD"]
    vpn_client_protocols = ["OpenVPN"]
    aad_tenant           = var.aad_tenant
    aad_audience         = var.settings.vpn_client_configuration.aad_audience
    aad_issuer           = var.aad_issuer
  }
}
