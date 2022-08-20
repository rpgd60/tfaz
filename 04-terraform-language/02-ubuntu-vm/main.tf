locals {
  name_suffix  = "${var.app_name}-${var.environment}-${var.region}"
  name_suffix2 = "${var.app_name}-${var.environment}-${var.region}2"

  dns_name  = "${var.app_name}-${random_string.rnd.result}"
  dns_name2 = "${var.app_name}-${random_string.rnd2.result}"
  tags = {
    Source          = "terraform"
    Env             = var.environment
    CostCenter      = var.cost_center
    ApplicationName = var.app_name
    # Project         = var.project
  }
}

resource "random_string" "rnd" {
  length  = 6
  upper   = false
  special = false
  numeric = false
}

resource "random_string" "rnd2" {
  length  = 6
  upper   = false
  special = false
  numeric = false
}
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.name_suffix}"
  location = var.region
  tags     = local.tags
}

resource "azurerm_linux_virtual_machine" "tfub_vm" {
  ## depends_on to prevent desttroy errors  
  ## destroying VM requies 
  ## See also https://azapril.dev/2020/05/12/terraform-depends_on/ 
  depends_on = [
    azurerm_network_interface_security_group_association.example
  ]
  name                  = "vm-${local.name_suffix}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.tfub_nic.id]
  size                  = var.vm_size

  os_disk {
    name                 = "osd-${local.name_suffix}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = local.dns_name
  admin_username                  = var.ssh_user
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.ssh_user
    public_key = file(var.ssh_pub_key_file)
  }


  tags = local.tags

  lifecycle {
    ignore_changes = [
      tags, ## Prevents TF from removing tags added to the VM outside of Terraform (e.g. by a mgmt application)
    ]
  }
}

resource "azurerm_linux_virtual_machine" "tfub_vm2" {
  ## depends_on to prevent desttroy errors  
  ## destroying VM requies 
  ## See also https://azapril.dev/2020/05/12/terraform-depends_on/ 
  depends_on = [
    azurerm_network_interface_security_group_association.example
  ]
  name                  = "vm-${local.name_suffix2}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.tfub_nic2.id]
  size                  = var.vm_size

  os_disk {
    name                 = "osd-${local.name_suffix2}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = local.dns_name2
  admin_username                  = var.ssh_user
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.ssh_user
    public_key = file(var.ssh_pub_key_file)
  }


  tags = local.tags

  lifecycle {
    ignore_changes = [
      tags, ## Prevents TF from removing tags added to the VM outside of Terraform (e.g. by a mgmt application)
    ]
  }
}