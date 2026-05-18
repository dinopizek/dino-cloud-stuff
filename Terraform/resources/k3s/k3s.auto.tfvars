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