Simple example of using a 3rd party module 

In this case we use the "official"  vnet module from Azure 
https://registry.terraform.io/modules/Azure/vnet/azurerm/latest
source code:
https://github.com/Azure/terraform-azurerm-vnet


The main purpose of this example is to understand the terminology of "calling" a module and then review all module concepts

Some exercises
call the module twice ->  each call creates a vnet resource.   We use those 2 vnet resources as part of the creation of 2 NICs


Some commands

```
rafa@rp3:00-use-module$ terraform state list
azurerm_network_interface.first_nic
azurerm_resource_group.rg
module.first_vnet.data.azurerm_resource_group.vnet
module.first_vnet.azurerm_subnet.subnet[0]
module.first_vnet.azurerm_subnet.subnet[1]
module.first_vnet.azurerm_virtual_network.vnet
```


