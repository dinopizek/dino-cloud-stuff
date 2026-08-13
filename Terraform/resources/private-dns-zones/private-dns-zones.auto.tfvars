conn_data_resource_groups = {
  "rg-use2-private-dns-prod-01" = {
    location = "eastus2"
  }
}

id_data_virtual_networks = {
  "vn-use2-iac-mes-prod-01" = {
    resource_group_name = "rg-use2-private-dns-prod-01"
  }
}

private_dns_zones = {
  privatelink_blob_core_windows_net = {
    name                = "privatelink.blob.core.windows.net"
    resource_group_name = "rg-use2-private-dns-prod-01"
  }
  privatelink_vaultcore_azure_net = {
    name                = "privatelink.vaultcore.azure.net"
    resource_group_name = "rg-use2-private-dns-prod-01"
  }
}

private_dns_zone_virtual_network_links = {
  pdnslink1 = {
    resource_group_name  = "rg-use2-iac-mes-network-prod-01"
    private_dns_zone_key = "privatelink_blob_core_windows_net"
    virtual_network_key  = "vn-use2-iac-mes-prod-01"
  }
  pdnslink2 = {
    resource_group_name  = "rg-use2-iac-mes-network-prod-01"
    private_dns_zone_key = "privatelink_vaultcore_azure_net"
    virtual_network_key  = "vn-use2-iac-mes-prod-01"
  }
}