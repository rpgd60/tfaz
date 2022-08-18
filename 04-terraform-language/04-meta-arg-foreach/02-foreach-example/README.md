Source :
https://stackoverflow.com/questions/70747582/terraform-nested-for-each-loop-in-azure-storage-account



echo local.flat_list | terraform console
```t
tolist([
  [
    "dev",        <------------------------------ each.value[0].name 
    {         
      "access_type" = "private"
      "name" = "cont-1"  <----------------------- each.value[1].name
    },
  ],
  [
    "dev",
    {
      "access_type" = "private"
      "name" = "cont-2"
    },
  ],
  [
    "prod",
    {
      "access_type" = "private"
      "name" = "cont-1"
    },
  ],
  [
    "prod",
    {
      "access_type" = "private"
      "name" = "cont-2"
    },
  ],
])

```
