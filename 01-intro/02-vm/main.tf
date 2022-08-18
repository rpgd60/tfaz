# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" ## any version 3.x  (in production, better pin a minor version)
    }
  }
  required_version = ">= 1.2.0" ## Required version of terraform itself
}

provider "azurerm" {
  features {}
  # subscription_id = "xxxxx"

}


resource "azurerm_resource_group" "tf1_rg" {
  name     = "rg-tf1"
  location = "West Europe" ## also accepts "westeurope"   (should come from variable)
}

resource "azurerm_virtual_network" "tf1_net" {
  name                = "net-tf1"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.tf1_rg.location
  resource_group_name = azurerm_resource_group.tf1_rg.name
}

resource "azurerm_subnet" "tf1_internal1" {
  name                 = "snet-internal1"
  resource_group_name  = azurerm_resource_group.tf1_rg.name
  virtual_network_name = azurerm_virtual_network.tf1_net.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_network_interface" "tf1" {
  name                = "nic-tf1"
  location            = azurerm_resource_group.tf1_rg.location
  resource_group_name = azurerm_resource_group.tf1_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.tf1_internal1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "tf1" {
  name                = "vm-tf1"
  resource_group_name = azurerm_resource_group.tf1_rg.name
  location            = azurerm_resource_group.tf1_rg.location
  ## watch out for capitalization of "DS1_v2"  
  size                = "Standard_DS1_v2" ## many of these values should come from variables (more later)
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.tf1.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/mykey.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  ## Below block comments (C-style)
  /*  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  } */

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  ## Below line comments 
  # source_image_reference {
  #   publisher = "Canonical"
  #   offer     = "UbuntuServer"
  #   sku       = "18.04-LTS"
  #   version   = "latest"
  # }
}
