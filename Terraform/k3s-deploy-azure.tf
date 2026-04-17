provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "k3s_resource_group" {
  name     = "rg-gewe-k3s-dino-01"
  location = "germanywestcentral"
  tags = {
    ManagedBy = "Terraform"
  }
}

resource "azurerm_virtual_network" "k3s_virtual_network" {
  name                = "vn-gewe-k3s-dino-01"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.k3s_resource_group.location
  resource_group_name = azurerm_resource_group.k3s_resource_group.name
}

resource "azurerm_subnet" "k3s_subnet" {
  name                 = "sn-k3s-dino-01"
  resource_group_name  = azurerm_resource_group.k3s_resource_group.name
  virtual_network_name = azurerm_virtual_network.k3s_virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "k3s_network_security_group" {
  name                = "nsg-vn-gewe-k3s-dino-01"
  location            = azurerm_resource_group.k3s_resource_group.location
  resource_group_name = azurerm_resource_group.k3s_resource_group.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "195.20.153.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "k3s-api"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "6443"
    source_address_prefix      = "195.20.153.0/24"
    destination_address_prefix = "*"
  }
}

locals {
  nodes = {
    "cp-01"     = { role = "control-plane" }
    "worker-01" = { role = "worker" }
    "worker-02" = { role = "worker" }
  }
}

resource "azurerm_public_ip" "k3s_public_ip" {
  for_each            = local.nodes
  name                = "pip-vm-gewe-k3s-${each.key}"
  location            = azurerm_resource_group.k3s_resource_group.location
  resource_group_name = azurerm_resource_group.k3s_resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "k3s_network_interface" {
  for_each            = local.nodes
  name                = "nic-vm-gewe-k3s-${each.key}"
  location            = azurerm_resource_group.k3s_resource_group.location
  resource_group_name = azurerm_resource_group.k3s_resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.k3s_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.k3s_public_ip[each.key].id
  }
}

resource "azurerm_network_interface_security_group_association" "k3s_nsg_association" {
  for_each                  = local.nodes
  network_interface_id      = azurerm_network_interface.k3s_network_interface[each.key].id
  network_security_group_id = azurerm_network_security_group.k3s_network_security_group.id
}

resource "azurerm_linux_virtual_machine" "k3s_virtual_machine" {
  for_each                        = local.nodes
  name                            = "vm-gewe-k3s-${each.key}"
  resource_group_name             = azurerm_resource_group.k3s_resource_group.name
  location                        = azurerm_resource_group.k3s_resource_group.location
  size                            = "Standard_B1s"
  admin_username                  = "azureuser"
  admin_password                  = "Jakalozinka!"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.k3s_network_interface[each.key].id,
  ]

  os_disk {
    name                 = "osdisk-vm-gewe-k3s-${each.key}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}