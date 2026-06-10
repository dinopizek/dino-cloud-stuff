resource_groups = {
  rg-gewe-workload-dino-01 = {
    location = "germanywestcentral"
    tags = {
      ManagedBy = "Terraform"
    }
  }
  rg-gewe-rsv-dino-01 = {
    location = "germanywestcentral"
    tags = {
      ManagedBy = "Terraform"
    }
  }
  rg-gewe-restorepoint-dino-01 = {
    location = "germanywestcentral"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

virtual_networks = {
  vn-gewe-sqlrestore-dino-01 = {
    address_space       = ["10.20.0.0/16"]
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-workload-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

subnets = {
  sn-vm-gewe-sqlrestore-dino-01 = {
    address_prefixes     = ["10.20.1.0/24"]
    resource_group_name  = "rg-gewe-workload-dino-01"
    virtual_network_name = "vn-gewe-sqlrestore-dino-01"
  }
}

network_security_groups = {
  nsg-sn-vm-gewe-sqlrestore-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-workload-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

network_security_rules = {
  allow-office = {
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "195.20.153.0/24"
    destination_address_prefix  = "*"
    resource_group_name         = "rg-gewe-workload-dino-01"
    network_security_group_name = "nsg-sn-vm-gewe-sqlrestore-dino-01"
  }
}

subnet_network_security_group_associations = {
  vm-subnet-nsg = {
    subnet_key                 = "sn-vm-gewe-sqlrestore-dino-01"
    network_security_group_key = "nsg-sn-vm-gewe-sqlrestore-dino-01"
  }
}

public_ips = {
  pip-vm-gewe-sqlrestore-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-workload-dino-01"
    allocation_method   = "Static"
    sku                 = "Standard"
    tags = {
      ManagedBy = "Terraform"
    }
  }
  pip-vm-gewe-sqlrestore-dino-02 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-workload-dino-01"
    allocation_method   = "Static"
    sku                 = "Standard"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

network_interfaces = {
  nic-vm-gewe-sqlrestore-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-workload-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
    ip_configuration = {
      name                          = "main-ipconfig"
      subnet_key                    = "sn-vm-gewe-sqlrestore-dino-01"
      public_ip_address_key         = "pip-vm-gewe-sqlrestore-dino-01"
      private_ip_address_allocation = "Dynamic"
    }
  }
  nic-vm-gewe-sqlrestore-dino-02 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-workload-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
    ip_configuration = {
      name                          = "main-ipconfig"
      subnet_key                    = "sn-vm-gewe-sqlrestore-dino-01"
      public_ip_address_key         = "pip-vm-gewe-sqlrestore-dino-02"
      private_ip_address_allocation = "Dynamic"
    }
  }
}

windows_virtual_machines = {
  vm-gewe-sqlrestore-dino-01 = {
    location              = "germanywestcentral"
    resource_group_name   = "rg-gewe-workload-dino-01"
    size                  = "Standard_B2ms"
    admin_username        = "azadmin"
    admin_password        = "ChangeMe123!"
    computer_name         = "vmgewesql01"
    network_interface_key = "nic-vm-gewe-sqlrestore-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
    os_disk = {
      name                 = "osdisk-vm-gewe-sqlrestore-dino-01"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2022-ws2022"
      sku       = "sqldev-gen2"
      version   = "latest"
    }
  }
  vm-gewe-sqlrestore-dino-02 = {
    location              = "germanywestcentral"
    resource_group_name   = "rg-gewe-workload-dino-01"
    size                  = "Standard_B2ms"
    admin_username        = "azadmin"
    admin_password        = "ChangeMe123!"
    computer_name         = "vmgewesql02"
    network_interface_key = "nic-vm-gewe-sqlrestore-dino-02"
    tags = {
      ManagedBy = "Terraform"
    }
    os_disk = {
      name                 = "osdisk-vm-gewe-sqlrestore-dino-02"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "MicrosoftSQLServer"
      offer     = "sql2022-ws2022"
      sku       = "sqldev-gen2"
      version   = "latest"
    }
  }
}

recovery_services_vaults = {
  rsv-gewe-sqlrestore-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-rsv-dino-01"
    sku                 = "Standard"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}
