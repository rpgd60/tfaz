Basic VM created by Terraform

Single file - all configuration in main.tf
This configuration does NOT follow best practices (monolithic file, hard-coded values, arbitrary naming of resources, etc.)
The purpose is to illustrate the basic workflow steps

Almost all other examples in the course will divide the configuration into multiple files.

Usual set of commands :

- terraform init (first time only)
- (save file(s)
- terraform fmt
- terraform validate
- terraform plan  
- (Revise the plan!)
- terraform apply

Verification of created VM

az vm list
az vm list --output table
az vm list --query "[*].name"
az vm list --query "[*].name"
az vm list --query "[*].{name:name,rg:resourceGroup}"


az vm list --query "[*].name"
```json
[
  "vm-tf1"
]
```
az vm list --query "[*].{name:name,rg:resourceGroup}"
```json
[
  {
    "name": "vm-tf1",
    "rg": "RG-TF1"
  }
]
```
