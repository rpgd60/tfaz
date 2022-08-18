Demo - Importing manually created AZ infra

Create a manual VM with basic parameters
Alternatively use ARM to create an ubuntu VM as in
https://docs.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-template




Imported 


Tried `terraform plan`
Failed with errors for each line in a security group (TCP vs Tcp)

```
╷
│ Error: expected protocol to be one of [* Tcp Udp Icmp Ah Esp], got TCP
│ 
│   with azurerm_network_security_rule.res-8,
│   on main.tf line 47, in resource "azurerm_network_security_rule" "res-8":
│   47:   protocol                    = "TCP"
│ 
╵
```

Is this related to a change in provider (2.x to 3.x)?

Modified "TCP" -> "Tcp" in main.tf

Terraform plan now works but wants to change "TCP" to "Tcp"

More tests
- Deleted infrastructure resources from Azure Console by deleting RG 
- Ran 'teraform apply'  - fails with error

```
│ Error: creating/updating Managed Disk "terrafy-test_DataDisk_0" (Resource Group "terrafy-test"): compute.DisksClient#CreateOrUpdate: Failure sending request: StatusCode=400 -- Original Error: Code="InvalidParameter" Message="Required parameter 'disk.diskSizeGb' is missing (null)." Target="disk.diskSizeGb"
│ 
│   with azurerm_managed_disk.res-5,
│   on main.tf line 26, in resource "azurerm_managed_disk" "res-5":
│   26: resource "azurerm_managed_disk" "res-5" {
```

Added `disk_size_gb = 8` to resource "azurerm_managed_disk" "res-5" 

Apply succeeded