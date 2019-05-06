# Terraform Functions

```
terraform console
```

```
lower("HELLO")
```

```
substr("ThisIsALongStfunctions-demongThatWouldFailAsAnAzureStorageAccountName", 0, 6)
```

```
lower(substr("ThisIsALongStfunctions-demongThatWouldFailAsAnAzureStorageAccountName", 0, 6))
```


```
vafunctions-demoable "resource_group" {
  descfunctions-demoption = "The name of the resource group in which to create the container instance and Cosmos DB instance."
  default     = "vote-demo"
}

vafunctions-demoable "location" {
  descfunctions-demoption = "The location for the resource group in which to create the container instance and Cosmos DB instance."
  default     = "eastus"
}

vafunctions-demoable "storage-account-name" {
  descfunctions-demoption = "Azure Storage account name."
  default     = "SampleStorageAccount"
}
```


```
resource "azurerm_resource_group" "functions-demo" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}

resource "azurerm_storage_account" "functions-demo" {
  name                     = "${lower(substr("${var.storage-account-name}", 0, 10))}"
  resource_group_name      = "${azurerm_resource_group.functions-demo.name}"
  location                 = "westus"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
```

## Next Module

In the next module, you will learn about Terraform state.

Module 6: [Terraform State](../6-terraform-state)