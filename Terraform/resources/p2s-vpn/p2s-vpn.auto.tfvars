resource_groups = {
  rg-gewe-p2s-hub-dino-01 = {
    location = "germanywestcentral"
    tags = {
      ManagedBy = "Terraform"
    }
  }
  rg-gewe-p2s-spoke1-dino-01 = {
    location = "germanywestcentral"
    tags = {
      ManagedBy = "Terraform"
    }
  }
  rg-gewe-p2s-spoke2-dino-01 = {
    location = "germanywestcentral"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

virtual_networks = {
  vn-gewe-p2s-hub-dino-01 = {
    address_space       = ["10.10.0.0/16"]
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-p2s-hub-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
  }
  vn-gewe-p2s-spoke1-dino-01 = {
    address_space       = ["10.11.0.0/16"]
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-p2s-spoke1-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
  }
  vn-gewe-p2s-spoke2-dino-01 = {
    address_space       = ["10.12.0.0/16"]
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-p2s-spoke2-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

subnets = {
  GatewaySubnet = {
    address_prefixes     = ["10.10.0.0/27"]
    resource_group_name  = "rg-gewe-p2s-hub-dino-01"
    virtual_network_name = "vn-gewe-p2s-hub-dino-01"
  }
  sn-vm-gewe-p2s-spoke1-dino-01 = {
    address_prefixes     = ["10.11.1.0/24"]
    resource_group_name  = "rg-gewe-p2s-spoke1-dino-01"
    virtual_network_name = "vn-gewe-p2s-spoke1-dino-01"
  }
  sn-vm-gewe-p2s-spoke2-dino-01 = {
    address_prefixes     = ["10.12.1.0/24"]
    resource_group_name  = "rg-gewe-p2s-spoke2-dino-01"
    virtual_network_name = "vn-gewe-p2s-spoke2-dino-01"
  }
}

network_security_groups = {
  nsg-sn-vm-gewe-p2s-spoke1-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-p2s-spoke1-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
  }
  nsg-sn-vm-gewe-p2s-spoke2-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-p2s-spoke2-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

network_security_rules = {
  allow-ssh-spoke1 = {
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "172.16.200.0/24"
    destination_address_prefix  = "*"
    resource_group_name         = "rg-gewe-p2s-spoke1-dino-01"
    network_security_group_name = "nsg-sn-vm-gewe-p2s-spoke1-dino-01"
  }
  allow-ssh-spoke2 = {
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "172.16.200.0/24"
    destination_address_prefix  = "*"
    resource_group_name         = "rg-gewe-p2s-spoke2-dino-01"
    network_security_group_name = "nsg-sn-vm-gewe-p2s-spoke2-dino-01"
  }
}

subnet_network_security_group_associations = {
  spoke1-nsg = {
    subnet_key                 = "sn-vm-gewe-p2s-spoke1-dino-01"
    network_security_group_key = "nsg-sn-vm-gewe-p2s-spoke1-dino-01"
  }
  spoke2-nsg = {
    subnet_key                 = "sn-vm-gewe-p2s-spoke2-dino-01"
    network_security_group_key = "nsg-sn-vm-gewe-p2s-spoke2-dino-01"
  }
}

route_tables = {
  rt-sn-vm-gewe-p2s-spoke1-dino-01 = {
    location                      = "germanywestcentral"
    resource_group_name           = "rg-gewe-p2s-spoke1-dino-01"
    bgp_route_propagation_enabled = true
    tags = {
      ManagedBy = "Terraform"
    }
    routes = [
      {
        name           = "to-vpn-clients"
        address_prefix = "172.16.200.0/24"
        next_hop_type  = "VirtualNetworkGateway"
      }
    ]
  }
  rt-sn-vm-gewe-p2s-spoke2-dino-01 = {
    location                      = "germanywestcentral"
    resource_group_name           = "rg-gewe-p2s-spoke2-dino-01"
    bgp_route_propagation_enabled = true
    tags = {
      ManagedBy = "Terraform"
    }
    routes = [
      {
        name           = "to-vpn-clients"
        address_prefix = "172.16.200.0/24"
        next_hop_type  = "VirtualNetworkGateway"
      }
    ]
  }
}

subnet_route_table_associations = {
  spoke1-rt = {
    subnet_key      = "sn-vm-gewe-p2s-spoke1-dino-01"
    route_table_key = "rt-sn-vm-gewe-p2s-spoke1-dino-01"
  }
  spoke2-rt = {
    subnet_key      = "sn-vm-gewe-p2s-spoke2-dino-01"
    route_table_key = "rt-sn-vm-gewe-p2s-spoke2-dino-01"
  }
}

public_ips = {
  pip-vpngw-gewe-p2s-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-p2s-hub-dino-01"
    allocation_method   = "Static"
    sku                 = "Standard"
    zones               = ["1", "2", "3"]
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

vpn_gateways = {
  vpngw-gewe-p2s-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-p2s-hub-dino-01"
    sku                 = "VpnGw1AZ"
    gateway_subnet_key  = "GatewaySubnet"
    public_ip_key       = "pip-vpngw-gewe-p2s-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
    vpn_client_configuration = {
      address_space = ["172.16.200.0/24"]
      # Official Azure VPN Enterprise Application ID (Azure Public Cloud)
      aad_audience = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
    }
  }
}

network_interfaces = {
  nic-vm-gewe-p2s-spoke1-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-p2s-spoke1-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
    ip_configuration = {
      name                          = "internal"
      subnet_key                    = "sn-vm-gewe-p2s-spoke1-dino-01"
      private_ip_address_allocation = "Dynamic"
    }
  }
  nic-vm-gewe-p2s-spoke2-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-p2s-spoke2-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
    ip_configuration = {
      name                          = "internal"
      subnet_key                    = "sn-vm-gewe-p2s-spoke2-dino-01"
      private_ip_address_allocation = "Dynamic"
    }
  }
}

linux_virtual_machines = {
  vm-gewe-p2s-spoke1-dino-01 = {
    location                        = "germanywestcentral"
    resource_group_name             = "rg-gewe-p2s-spoke1-dino-01"
    size                            = "Standard_B1s"
    admin_username                  = "azadmin"
    admin_password                  = "ChangeMe123!"
    disable_password_authentication = false
    network_interface_key           = "nic-vm-gewe-p2s-spoke1-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
    os_disk = {
      name                 = "osdisk-vm-gewe-p2s-spoke1-dino-01"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "ubuntu-24_04-lts"
      sku       = "server"
      version   = "latest"
    }
  }
  vm-gewe-p2s-spoke2-dino-01 = {
    location                        = "germanywestcentral"
    resource_group_name             = "rg-gewe-p2s-spoke2-dino-01"
    size                            = "Standard_B1s"
    admin_username                  = "azadmin"
    admin_password                  = "ChangeMe123!"
    disable_password_authentication = false
    network_interface_key           = "nic-vm-gewe-p2s-spoke2-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
    os_disk = {
      name                 = "osdisk-vm-gewe-p2s-spoke2-dino-01"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "ubuntu-24_04-lts"
      sku       = "server"
      version   = "latest"
    }
  }
}

virtual_network_peerings = {
  peer-hub-to-spoke1 = {
    resource_group_name          = "rg-gewe-p2s-hub-dino-01"
    virtual_network_name         = "vn-gewe-p2s-hub-dino-01"
    remote_virtual_network_key   = "vn-gewe-p2s-spoke1-dino-01"
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit        = true
    use_remote_gateways          = false
  }
  peer-hub-to-spoke2 = {
    resource_group_name          = "rg-gewe-p2s-hub-dino-01"
    virtual_network_name         = "vn-gewe-p2s-hub-dino-01"
    remote_virtual_network_key   = "vn-gewe-p2s-spoke2-dino-01"
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit        = true
    use_remote_gateways          = false
  }
  peer-spoke1-to-hub = {
    resource_group_name          = "rg-gewe-p2s-spoke1-dino-01"
    virtual_network_name         = "vn-gewe-p2s-spoke1-dino-01"
    remote_virtual_network_key   = "vn-gewe-p2s-hub-dino-01"
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit        = false
    use_remote_gateways          = true
  }
  peer-spoke2-to-hub = {
    resource_group_name          = "rg-gewe-p2s-spoke2-dino-01"
    virtual_network_name         = "vn-gewe-p2s-spoke2-dino-01"
    remote_virtual_network_key   = "vn-gewe-p2s-hub-dino-01"
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit        = false
    use_remote_gateways          = true
  }
}
