Example of using a 3rd party module 

In this case we use the "official"  vnet module from Azure 
https://registry.terraform.io/modules/Azure/vnet/azurerm/latest

We re write the basic ubuntu vm code but calling the vnet module instead of creating the azurerm_virtual_network and azurerm_subnet resources directly

Note that we pin a specific  version of the module (latest 2.7.0 as of this writing) - this is considered a best practice for module usage, to avoid unexpected changes if the author of the module makes changes that break our code.

Note that the VM definition does not change.  Only the NIC definition references the subnet and indirectly the virtual network

# Using terraform output to automate access to VM
KEY_NAME=mykey
PUB_IP=$(terraform output  -json | jq -r .public_ip.value)
AZ_USER=$(terraform output  -json | jq -r .vm_admin_user.value)
echo "connecting to: $PUB_IP as $AZ_USER"
echo "with key $KEY_NAME"
ssh -i ~/.ssh/$KEY_NAME $AZ_USER@$PUB_IP