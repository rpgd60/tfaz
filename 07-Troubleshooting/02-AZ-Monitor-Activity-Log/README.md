Run terraform plan/apply/destroy in 04-terraform-language/02-ubuntu-vm

Then explore Azure Monitor Activity Log  in portal and with CLI

Portal link:
https://portal.azure.com/#view/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/~/activityLog
(select appropriate timespan, e.g. 1 hour)



```
az monitor activity-log list --offset 1h
```
## terraform plan
(run at 9:13+ am)
(no events - apparently not capturing "read" API calls)

## terraform apply -auto-approve
(run at 9:16+ am CET,  finished at 09:17:53 am CET)


## destroy 
start : Sun 21 Aug 2022 10:25:43 CEST
finish : Sun 21 Aug 2022 10:29:05 CEST

az monitor activity-log list --offset 8h --query "[].{submit:submissionTimestamp, event:eventTimestamp, opName: operationName.value, id:id}"

  {
    "event": "2022-08-21T15:58:57.388510+00:00",
    "id": "/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-ubuntu-02-dev-eastus/providers/Microsoft.Compute/virtualMachines/vm-ubuntu-02-dev-eastus/events/67810122-dcdf-4ea1-a676-5b3e82f54ee7/ticks/637966943373885104",
    "opName": "Microsoft.Compute/virtualMachines/powerOff/action",
    "submit": "2022-08-21T16:00:08.142880+00:00"
  }
]

