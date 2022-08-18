resource "azurerm_subnet" "res-9" {
  address_prefixes                               = ["10.0.0.0/24"]
  enforce_private_link_endpoint_network_policies = true
  name                                           = "default"
  resource_group_name                            = "terrafy-test"
  virtual_network_name                           = "terrafy-test-vnet"
  depends_on = [
    azurerm_virtual_network.res-3,
  ]
}
resource "azurerm_resource_group" "res-11" {
  location = "westeurope"
  name     = "terrafy-test"
}
resource "azurerm_network_security_group" "res-1" {
  location            = "westeurope"
  name                = "terrafy-test-nsg"
  resource_group_name = "terrafy-test"
  tags = {
    cost-center = "322233"
  }
  depends_on = [
    azurerm_resource_group.res-11,
  ]
}
resource "azurerm_managed_disk" "res-5" {
  create_option        = "Empty"
  location             = "westeurope"
  name                 = "terrafy-test_DataDisk_0"
  resource_group_name  = "terrafy-test"
  storage_account_type = "StandardSSD_LRS"
  tags = {
    cost-center = "322233"
  }
  depends_on = [
    azurerm_resource_group.res-11,
  ]
  disk_size_gb = 8
}
resource "azurerm_network_security_rule" "res-8" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  direction                   = "Inbound"
  name                        = "SSH"
  network_security_group_name = "terrafy-test-nsg"
  priority                    = 300
  protocol                    = "Tcp"
  resource_group_name         = "terrafy-test"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-1,
  ]
}
resource "azurerm_network_security_rule" "res-6" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "80"
  direction                   = "Inbound"
  name                        = "HTTP"
  network_security_group_name = "terrafy-test-nsg"
  priority                    = 320
  protocol                    = "Tcp"
  resource_group_name         = "terrafy-test"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-1,
  ]
}
resource "azurerm_network_security_rule" "res-7" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "HTTPS"
  network_security_group_name = "terrafy-test-nsg"
  priority                    = 340
  protocol                    = "Tcp"
  resource_group_name         = "terrafy-test"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-1,
  ]
}
resource "azurerm_network_interface" "res-10" {
  enable_accelerated_networking = true
  location                      = "westeurope"
  name                          = "terrafy-test473"
  resource_group_name           = "terrafy-test"
  tags = {
    cost-center = "322233"
  }
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/86b2fde3-ca70-4813-8ef3-ade20d2666d3/resourceGroups/terrafy-test/providers/Microsoft.Network/publicIPAddresses/terrafy-test-ip"
    subnet_id                     = "/subscriptions/86b2fde3-ca70-4813-8ef3-ade20d2666d3/resourceGroups/terrafy-test/providers/Microsoft.Network/virtualNetworks/terrafy-test-vnet/subnets/default"
  }
  depends_on = [
    azurerm_public_ip.res-2,
    azurerm_subnet.res-9,
    azurerm_network_security_group.res-1,
  ]
}
resource "azurerm_ssh_public_key" "res-0" {
  location            = "westeurope"
  name                = "terrafy-test_key"
  public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9ZXV+6mT9tTeRbWP9Hm1JSaADZDoQjLRhgI15cw81+nHTa0IHU680OXaeqqoMMMVYt+3ZAxjyYrjenQJ6dvui+QWyLDmQUnP8QoQ6nxi0X426mUhMzlq6pEQpQIhpxhN2qhvzrRRaEisegQhHtQPvd2i4GeYjlbkOMvko0I/V6K2flRLZ8CpXIICnhrwKLBVwBQqlzd0ayOGjq5DiyXvDYjJ9NiMe3hNvyrDn/iS7Ck6xZ1uQhzoYx/+vH2wFPEiS9g8vqZ7mvMIYxH/VmXzgsUMPaN5ROlbBPDCi/rhjwlvA9zjZ2ReuJ4o15aKQztOgxyziZ1/F+xWHQI7FPwxeqYd6Lv+ems3a1+WIRTXsmpZ0z4mxJsnundwhzgkLViE1nHcQpPunGG7ARdO1GUgwwl2Ufcc2jfxH+4xhABYufr3QNRI4Cn+XUaJbwjOLlzr1Nq+6cWFvciA2mWhIoIUQq1KXejaWJm6XkjxlZ6G2oPw6v9UPZVLa4DSyJHkYuGE= generated-by-azure"
  resource_group_name = "terrafy-test"
  tags = {
    cost-center = "322233"
  }
  depends_on = [
    azurerm_resource_group.res-11,
  ]
}
resource "azurerm_public_ip" "res-2" {
  allocation_method   = "Dynamic"
  location            = "westeurope"
  name                = "terrafy-test-ip"
  resource_group_name = "terrafy-test"
  tags = {
    cost-center = "322233"
  }
  depends_on = [
    azurerm_resource_group.res-11,
  ]
}
resource "azurerm_virtual_network" "res-3" {
  address_space       = ["10.0.0.0/16"]
  location            = "westeurope"
  name                = "terrafy-test-vnet"
  resource_group_name = "terrafy-test"
  tags = {
    cost-center = "322233"
  }
  depends_on = [
    azurerm_resource_group.res-11,
  ]
}