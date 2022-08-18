resource "azurerm_resource_group" "res-0" {
  location = "westeurope"
  name     = "rg-vmss-test2"
  tags = {
    Source = "portal"
  }
}
resource "azurerm_lb_backend_address_pool" "res-4" {
  loadbalancer_id = "/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-vmss-test2/providers/Microsoft.Network/loadBalancers/vmss-test2-lb"
  name            = "bepool"
  depends_on = [
    azurerm_lb.res-3,
  ]
}
resource "azurerm_subnet" "res-9" {
  address_prefixes                               = ["10.1.0.0/16"]
  enforce_private_link_endpoint_network_policies = true
  name                                           = "default"
  resource_group_name                            = "rg-vmss-test2"
  virtual_network_name                           = "rg-vmss-test2-vnet"
  depends_on = [
    azurerm_virtual_network.res-8,
  ]
}
resource "azurerm_linux_virtual_machine_scale_set" "res-1" {
  admin_username         = "azureuser"
  instances              = 1
  location               = "westeurope"
  name                   = "vmss-test2"
  overprovision          = false
  resource_group_name    = "rg-vmss-test2"
  single_placement_group = false
  sku                    = "Standard_DS1_v2"
  tags = {
    "Source " = "portal"
  }
  zones = ["1", "2"]
  admin_ssh_key {
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCU0lWQ2MFIxr5xpHRKEzdOK1ZL5Q0/7O6UWraGrYEWIVGMH7ho/tOfF99ZdKK6VZ9T/jvnphrUrDE4JUMHoQIpHfIYJhUxqR9yGGxm7zTa1DR17t/0n42+kk+LsaoQZU7pYtoqBLu1OtZe8oweHs0HmoMP4wNbQ83O0TJBI1beSCin3TdHStO3+C0svKQG6YlsXEM+FyLrS4fNYPj1KJ/paPsgOx0nl26SJuriDGvlCYsPz0uiisvIYYE93sKPLjzMhnYMW0nJFzyOx5U3iIu2YP1mXyQfKsRXYafcMYg9GmFsq7dfca5Qi8jt8tLr0PI9vjCntbDEPfHIAPTf67ib7mnWp3cTHOR9KB3W/606m1h9oQlokipSQjeMJ/K/IbtQa67k1NtL3bSkJcjWe6WYctDlz69C9UTWmBsZKAv1TmtxoHIvYfHRaTpQS4uH2wdaH01HxSssLMgXorRnapsH0ifHtmWYG3m8V0yNzk3DgcbJSrNdU20COG2s9YNX35E= rafa@rp3"
    username   = "azureuser"
  }
  network_interface {
    enable_accelerated_networking = true
    name                          = "rg-vmss-test2-vnet-nic01"
    network_security_group_id     = "/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-vmss-test2/providers/Microsoft.Network/networkSecurityGroups/basicNsgrg-vmss-test2-vnet-nic01"
    primary                       = true
    ip_configuration {
      load_balancer_backend_address_pool_ids = ["/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-vmss-test2/providers/Microsoft.Network/loadBalancers/vmss-test2-lb/backendAddressPools/bepool"]
      load_balancer_inbound_nat_rules_ids    = ["/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-vmss-test2/providers/Microsoft.Network/loadBalancers/vmss-test2-lb/inboundNatPools/natpool"]
      name                                   = "rg-vmss-test2-vnet-nic01-defaultIpConfiguration"
      primary                                = true
      subnet_id                              = "/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-vmss-test2/providers/Microsoft.Network/virtualNetworks/rg-vmss-test2-vnet/subnets/default"
    }
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    offer     = "0001-com-ubuntu-server-focal"
    publisher = "canonical"
    sku       = "20_04-lts"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_security_group.res-6,
    azurerm_subnet.res-9,
    azurerm_lb_backend_address_pool.res-4,
    azurerm_lb.res-3,
  ]
}
resource "azurerm_lb" "res-3" {
  location            = "westeurope"
  name                = "vmss-test2-lb"
  resource_group_name = "rg-vmss-test2"
  sku                 = "Standard"
  tags = {
    "Source " = "portal"
  }
  frontend_ip_configuration {
    name = "LoadBalancerFrontEnd"
  }
  depends_on = [
    azurerm_public_ip.res-7,
    azurerm_lb_backend_address_pool.res-4,
  ]
}
resource "azurerm_lb_nat_rule" "res-5" {
  backend_port                   = 22
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  frontend_port                  = 50001
  loadbalancer_id                = "/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-vmss-test2/providers/Microsoft.Network/loadBalancers/vmss-test2-lb"
  name                           = "natpool.1"
  protocol                       = "Tcp"
  resource_group_name            = "rg-vmss-test2"
  depends_on = [
    azurerm_lb.res-3,
  ]
}
resource "azurerm_network_security_group" "res-6" {
  location            = "westeurope"
  name                = "basicNsgrg-vmss-test2-vnet-nic01"
  resource_group_name = "rg-vmss-test2"
  tags = {
    "Source " = "portal"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_public_ip" "res-7" {
  allocation_method   = "Static"
  location            = "westeurope"
  name                = "vmss-test2-ip"
  resource_group_name = "rg-vmss-test2"
  sku                 = "Standard"
  tags = {
    "Source " = "portal"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_virtual_network" "res-8" {
  address_space       = ["10.1.0.0/16"]
  location            = "westeurope"
  name                = "rg-vmss-test2-vnet"
  resource_group_name = "rg-vmss-test2"
  tags = {
    "Source " = "portal"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_monitor_autoscale_setting" "res-10" {
  location            = "westeurope"
  name                = "vmss-test2autoscale"
  resource_group_name = "rg-vmss-test2"
  target_resource_id  = "/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-vmss-test2/providers/Microsoft.Compute/virtualMachineScaleSets/vmss-test2"
  profile {
    name = "Profile1"
    capacity {
      default = 1
      maximum = 10
      minimum = 1
    }
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = "/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-vmss-test2/providers/Microsoft.Compute/virtualMachineScaleSets/vmss-test2"
        operator           = "GreaterThan"
        statistic          = "Average"
        threshold          = 75
        time_aggregation   = "Average"
        time_grain         = "PT1M"
        time_window        = "PT10M"
      }
      scale_action {
        cooldown  = "PT1M"
        direction = "Increase"
        type      = "ChangeCount"
        value     = 1
      }
    }
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = "/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-vmss-test2/providers/Microsoft.Compute/virtualMachineScaleSets/vmss-test2"
        operator           = "LessThan"
        statistic          = "Average"
        threshold          = 25
        time_aggregation   = "Average"
        time_grain         = "PT1M"
        time_window        = "PT5M"
      }
      scale_action {
        cooldown  = "PT1M"
        direction = "Decrease"
        type      = "ChangeCount"
        value     = 1
      }
    }
  }
  depends_on = [
    azurerm_linux_virtual_machine_scale_set.res-1,
  ]
}
