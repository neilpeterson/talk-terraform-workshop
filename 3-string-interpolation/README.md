# Terraform Core Concepts

## Module Overview

- String Interpolation
- Terraform Plan

## Create an Azure Cosmos Database

Open the previously created configuration found in the main.tf file. The contents should match the following. If needed, recreate the file.

```
resource "azurerm_resource_group" "vote-resource-group" {
  name     = "vote-resource-group"
  location = "westus"
}
```

We now want to add an Azure Container Instance to the configuration. The trick is though that we want the resource created inside of the resource group that is also defined in the configuration. To do so we need the resource group, which can be derived using a process referred to as string interpolation.

Update the configuration so that it looks like this. Notice that a second configuration block is defined for the Azure Container Instances (azurerm_resource_group). Also notice the syntax that makes up the container instance location, resource_group_name, and dns_name_label. The values are derived from the azure_resoure_group using the notation `${azurerm_resource_group.vote-resource-group.name}`.

```
resource "azurerm_resource_group" "vote-resource-group" {
  name     = "vote-resource-group"
  location = "westus"
}

resource "azurerm_container_group" "vote-aci" {
  name                = "vote-aci"
  location            = "${azurerm_resource_group.vote-resource-group.location}"
  resource_group_name = "${azurerm_resource_group.vote-resource-group.name}"
  ip_address_type     = "public"
  dns_name_label      = "${azurerm_resource_group.vote-resource-group.name}"
  os_type             = "linux"

  container {
    name   = "vote-aci"
    image  = "microsoft/aci-helloworld"
    cpu    = "0.5"
    memory = "1.5"
    port   = "80"
  }
}
```

Run `terraform init` to ensure the directory is initialized.

```
terraform init
```

This time instead of running `terraform apply` to run the configuration, use `terraform plan --out plan.out` to visualize what will be created and produce a plan file.

```
terraform plan --out plan.out
```

Use `terraform apply plan.out` to apply the plan.

```
terraform apply plan.out
```

## Next Module

In the next module, you will learn about some additional Terraform concepts.

Module 4: [Terraform Additional Concepts](../4-input-variables)