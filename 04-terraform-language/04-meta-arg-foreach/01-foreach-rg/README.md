
## Teraform console
After running terraform init we can run terraform console.
Note that terraform console locks the state 

element([1,2,3],0)
length([1,2,3])

## Examples of terraform console

echo azurerm_resource_group.rg-test | terraform console
```
[
  {
    "id" = "/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-test-0"
    "location" = "westeurope"
    "name" = "rg-test-0"
    "tags" = tomap(null) /* of string */
    "timeouts" = null /* object */
  },
  {
    "id" = "/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-test-1"
    "location" = "westeurope"
    "name" = "rg-test-1"
    "tags" = tomap(null) /* of string */
    "timeouts" = null /* object */
  },
  {
    "id" = "/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-test-2"
    "location" = "westeurope"
    "name" = "rg-test-2"
    "tags" = tomap(null) /* of string */
    "timeouts" = null /* object */
  },
]
```
echo azurerm_resource_group.rg-test[1] | terraform console
```
{
  "id" = "/subscriptions/a1e01a15-61aa-4f25-aa66-6d6e8a913dc3/resourceGroups/rg-test-1"
  "location" = "westeurope"
  "name" = "rg-test-1"
  "tags" = tomap(null) /* of string */
  "timeouts" = null /* object */
}
```

Example of splat

echo azurerm_resource_group.rg-test[*].name | terraform console
```
[
  "rg-test-0",
  "rg-test-1",
  "rg-test-2",
]
```
