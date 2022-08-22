
resource "azurerm_virtual_network" "tfub_network" {
  name                = "vnet-${local.name_suffix}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
}

resource "azurerm_subnet" "tfub_subnet" {
  name                 = "snet-${local.name_suffix}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.tfub_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "tfub_publicip" {
  count               = var.num_vms
  name                = "pip-${local.name_suffix}-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${local.dns_name}-${count.index}"
  tags                = local.tags

}

resource "azurerm_network_security_group" "tfub_nsg" {
  name                = "nsg-${local.name_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "nsgr-SSH"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.tfub_nsg.name
}

resource "azurerm_network_security_rule" "icmp" {
  name                        = "nsgr-icmp"
  priority                    = 1102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Icmp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.tfub_nsg.name
}

# resource "azurerm_network_security_rule" "http" {
#   name                        = "nsgr-http"
#   priority                    = 1202
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Http"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.rg.name
#   network_security_group_name = azurerm_network_security_group.tfub_nsg.name
# }

resource "azurerm_network_interface" "tfub_nic" {
  count               = var.num_vms
  name                = "nic-${local.name_suffix}-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "NicConfig"
    subnet_id                     = azurerm_subnet.tfub_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tfub_publicip[count.index].id
  }
  tags = local.tags
}

# Connect the security group to the network interfaces
resource "azurerm_network_interface_security_group_association" "example" {
  count                     = var.num_vms
  network_interface_id      = azurerm_network_interface.tfub_nic[count.index].id
  network_security_group_id = azurerm_network_security_group.tfub_nsg.id
}
