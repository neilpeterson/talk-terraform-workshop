# Terraform State

## Module Overview

- Create an Azure Storage account
- Configure backend state store
- Delete and recreate state

```
#!/bin/bash

RESOURCE_GROUP_NAME=tstate
STORAGE_ACCOUNT_NAME=tstate$RANDOM
CONTAINER_NAME=tstate

# Create a resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY"
```

```
export ARM_ACCESS_KEY=<access_key>
```

```
terraform {
  backend "azurerm" {
    storage_account_name  = "storage_account_name"
    container_name        = "tstate"
    key                   = "terraform.tfstate"
  }
}
```

## Next Module

In the next module, you will learn to modularize and re-use terraform configurations.

Module 4: [Terraform Modules](../5-terraform-modules)