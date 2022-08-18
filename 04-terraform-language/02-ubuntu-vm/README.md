## Sample Linux VM creation
Originally based on  Azure Documentation : 
https://docs.microsoft.com/en-us/azure/developer/terraform/create-linux-virtual-machine-with-infrastructure

With extensive modifications
- Removed generated private ssh key - use private key generated outside terraform
- Use local variables for tagging and naming of resources 


For resource naming - following (partially) best practices recommended at:
https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations

For tagging:
https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging



## Tips and Activities to explore

## Using terraform output to automate access to VM
```bash
KEY_NAME=mykey
PUB_IP=$(terraform output  -json | jq -r .public_ip.value)
AZ_USER=$(terraform output  -json | jq -r .vm_admin_user.value)
echo "connecting to: $PUB_IP as $AZ_USER"
echo "with key $KEY_NAME"
ssh -i ~/.ssh/$KEY_NAME $AZ_USER@$PUB_IP
```

### Resource modification in place - for example add one tag 
- Modify the value of a variable (e.g. terraform plan -var ....  (same with apply))
- Add a variable (e.g. project) in variables.tf and a corresponding tag in local

## Resource destroy and re-create
- change an attribute (e.g. vm size ) that requires destroying and re-creating the resources


## Testing variable validation
```txt
rafa@rp3:02-ubuntu-vm$ terraform plan -var="environment=foobar"
╷
│ Error: Invalid value for variable
│ 
│   on variables.tf line 24:
│   24: variable "environment" {
│     ├────────────────
│     │ var.environment is "foobar"
│ 
│ Err: invalid environment.
│ 
│ This was checked by the validation rule at variables.tf:29,3-13.
╵
╷
│ Error: Invalid value for variable
│ 
│   on variables.tf line 24:
│   24: variable "environment" {
│     ├────────────────
│     │ var.environment is "foobar"
│ 
│ Err: environment is too long.
│ 
│ This was checked by the validation rule at variables.tf:34,3-13.


rafa@rp3:02-ubuntu-vm$ terraform plan -var="region=northeurope"
╷
│ Error: Invalid value for variable
│ 
│   on variables.tf line 1:
│    1: variable "region" {
│     ├────────────────
│     │ var.region is "northeurope"
│ 
│ Err: Region not allowed.
│ 
│ This was checked by the validation rule at variables.tf:6,3-13.
```
commit from Mac 

## Graph
After installing graphviz 

terraform graph | dot -Tpng > graph.png

