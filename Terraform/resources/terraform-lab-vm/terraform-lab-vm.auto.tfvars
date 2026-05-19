resource_groups = {
  rg-sc-terraform-lab-01 = {
    location = "swedencentral"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

virtual_networks = {
  vn-sc-terraform-lab-01 = {
    address_space       = ["10.2.0.0/16"]
    location            = "swedencentral"
    resource_group_name = "rg-sc-terraform-lab-01"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

subnets = {
  sn-vm-terraform-lab-01 = {
    address_prefixes     = ["10.2.0.0/24"]
    resource_group_name  = "rg-sc-terraform-lab-01"
    virtual_network_name = "vn-sc-terraform-lab-01"
  }
}

network_security_groups = {
  nsg-sn-vm-terraform-lab-01 = {
    location            = "swedencentral"
    resource_group_name = "rg-sc-terraform-lab-01"
  }
}

subnet_network_security_group_associations = {
  vm_nsg_association = {
    subnet_key                 = "sn-vm-terraform-lab-01"
    network_security_group_key = "nsg-sn-vm-terraform-lab-01"
  }
}

public_ips = {
  pip-vm-sc-terraform-lab-01 = {
    location            = "swedencentral"
    resource_group_name = "rg-sc-terraform-lab-01"
    allocation_method   = "Static"
    sku                 = "Standard"
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

network_interfaces = {
  nic-vm-sc-terraform-lab-01 = {
    location            = "swedencentral"
    resource_group_name = "rg-sc-terraform-lab-01"
    tags = {
      ManagedBy = "Terraform"
    }
    ip_configuration = {
      name                          = "internal"
      subnet_key                    = "sn-vm-terraform-lab-01"
      private_ip_address_allocation = "Dynamic"
      public_ip_address_key         = "pip-vm-sc-terraform-lab-01"
    }
  }
}

linux_virtual_machines = {
  vm-sc-terraform-lab-01 = {
    location            = "swedencentral"
    resource_group_name = "rg-sc-terraform-lab-01"
    size                = "Standard_B1s"
    tags = {
      ManagedBy = "Terraform"
    }
    admin_username                  = "dino"
    admin_password                  = "ChangeMe123!"
    disable_password_authentication = false
    network_interface_key           = "nic-vm-sc-terraform-lab-01"
    os_disk = {
      name                 = "osdisk-vm-sc-terraform-lab-01"
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
    resource_group_name         = "rg-sc-terraform-lab-01"
    network_security_group_name = "nsg-sn-vm-terraform-lab-01"
  }
}