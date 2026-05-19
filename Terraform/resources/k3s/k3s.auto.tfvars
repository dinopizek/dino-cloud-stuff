resource_groups = {
  rg-gewe-k3s-dino-01 = {
    location = "germanywestcentral"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

virtual_networks = {
  vn-gewe-k3s-dino-01 = {
    address_space       = ["10.0.0.0/16"]
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-k3s-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

subnets = {
  sn-k3s-dino-01 = {
    resource_group_name  = "rg-gewe-k3s-dino-01"
    virtual_network_name = "vn-gewe-k3s-dino-01"
    address_prefixes     = ["10.0.0.0/24"]
  }
}

network_security_groups = {
  nsg-vn-gewe-k3s-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-k3s-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

public_ips = {
  pip-vm-gewe-k3s-master-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-k3s-dino-01"
    allocation_method   = "Static"
    sku                 = "Standard"
    tags = {
      ManagedBy = "Terraform"
    }
  }
  pip-vm-gewe-k3s-worker-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-k3s-dino-01"
    allocation_method   = "Static"
    sku                 = "Standard"
    tags = {
      ManagedBy = "Terraform"
    }
  }
  pip-vm-gewe-k3s-worker-dino-02 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-k3s-dino-01"
    allocation_method   = "Static"
    sku                 = "Standard"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

network_interfaces = {
  nic-vm-gewe-k3s-master-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-k3s-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
    ip_configuration = {
      name                          = "internal"
      subnet_key                    = "sn-k3s-dino-01"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_key         = "pip-vm-gewe-k3s-master-dino-01"
    }
  }
  nic-vm-gewe-k3s-worker-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-k3s-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
    ip_configuration = {
      name                          = "internal"
      subnet_key                    = "sn-k3s-dino-01"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_key         = "pip-vm-gewe-k3s-worker-dino-01"
    }
  }
  nic-vm-gewe-k3s-worker-dino-02 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-k3s-dino-01"
    tags = {
      ManagedBy = "Terraform"
    }
    ip_configuration = {
      name                          = "internal"
      subnet_key                    = "sn-k3s-dino-01"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_key         = "pip-vm-gewe-k3s-worker-dino-02"
    }
  }
}

network_security_group_associations = {
  nsg_assoc_master = {
    network_interface_key      = "nic-vm-gewe-k3s-master-dino-01"
    network_security_group_key = "nsg-vn-gewe-k3s-dino-01"
  }
  nsg_assoc_worker_01 = {
    network_interface_key      = "nic-vm-gewe-k3s-worker-dino-01"
    network_security_group_key = "nsg-vn-gewe-k3s-dino-01"
  }
  nsg_assoc_worker_02 = {
    network_interface_key      = "nic-vm-gewe-k3s-worker-dino-02"
    network_security_group_key = "nsg-vn-gewe-k3s-dino-01"
  }
}

linux_virtual_machines = {
  vm-gewe-k3s-master-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-k3s-dino-01"
    size                = "Standard_B1s"
    tags = {
      ManagedBy = "Terraform"
    }
    admin_username                  = "azadmin"
    admin_password                  = "ChangeMe123!"
    disable_password_authentication = false
    network_interface_keys          = ["nic-vm-gewe-k3s-master-dino-01"]
    os_disk = {
      name                 = "osdisk-vm-gewe-k3s-master-dino-01"
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
  vm-gewe-k3s-worker-dino-01 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-k3s-dino-01"
    size                = "Standard_B1s"
    tags = {
      ManagedBy = "Terraform"
    }
    admin_username                  = "azadmin"
    admin_password                  = "ChangeMe123!"
    disable_password_authentication = false
    network_interface_keys          = ["nic-vm-gewe-k3s-worker-dino-01"]
    os_disk = {
      name                 = "osdisk-vm-gewe-k3s-worker-dino-01"
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
  vm-gewe-k3s-worker-dino-02 = {
    location            = "germanywestcentral"
    resource_group_name = "rg-gewe-k3s-dino-01"
    size                = "Standard_B1s"
    tags = {
      ManagedBy = "Terraform"
    }
    admin_username                  = "azadmin"
    admin_password                  = "ChangeMe123!"
    disable_password_authentication = false
    network_interface_keys          = ["nic-vm-gewe-k3s-worker-dino-02"]
    os_disk = {
      name                 = "osdisk-vm-gewe-k3s-worker-dino-02"
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

network_security_rules = {
  allow_ssh = {
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "195.20.153.0/24"
    destination_address_prefix  = "*"
    resource_group_name         = "rg-gewe-k3s-dino-01"
    network_security_group_name = "nsg-vn-gewe-k3s-dino-01"
  }
  allow_k3s_api = {
    priority                    = 110
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "6443"
    source_address_prefix       = "195.20.153.0/24"
    destination_address_prefix  = "*"
    resource_group_name         = "rg-gewe-k3s-dino-01"
    network_security_group_name = "nsg-vn-gewe-k3s-dino-01"
  }
}