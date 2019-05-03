# Terraform Variables

## Module Overview

- Input variables
- Output variables

## Create variables file

```
variable "resource_group" {
  description = "The name of the resource group in which to create the container instance and Cosmos DB instance."
  default     = "vote-demo"
}

variable "location" {
  description = "The location for the resource group in which to create the container instance and Cosmos DB instance."
  default     = "eastus"
}

variable "dns-prefix" {
  description = "DNS prefix for the public IP address of the container instance."
  default     = "vote-demo"
}

variable "container-image" {
  description = "Container image for the Azure Vote Flask application."
  default     = "microsoft/azure-vote-front:cosmosdb"
}
```

## Add a Microsoft Azure Consmos Database

```
resource "azurerm_resource_group" "vote-app" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_cosmosdb_account" "vote-app" {
  name                = "tfex-cosmos-db-${random_integer.ri.result}"
  location            = "${azurerm_resource_group.vote-app.location}"
  resource_group_name = "${azurerm_resource_group.vote-app.name}"
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = true

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = "westus"
    failover_priority = 0
  }
}

resource "azurerm_container_group" "vote-app" {
  name                = "vote-app"
  location            = "${azurerm_resource_group.vote-app.location}"
  resource_group_name = "${azurerm_resource_group.vote-app.name}"
  ip_address_type     = "public"
  dns_name_label      = "${var.dns-prefix}"
  os_type             = "linux"

  container {
    name   = "vote-app"
    image  = "${var.container-image}"
    cpu    = "0.5"
    memory = "1.5"
    port   = "80"

    environment_variables {
      "COSMOS_DB_ENDPOINT"  = "${azurerm_cosmosdb_account.vote-app.endpoint}"
      "COSMOS_DB_MASTERKEY" = "${azurerm_cosmosdb_account.vote-app.primary_master_key}"
      "TITLE"               = "Azure Voting App"
      "VOTE1VALUE"          = "Cats"
      "VOTE2VALUE"          = "Dogs"
    }
  }
}
```

Add output variable to surface ip address.

```
output "ip_address" {
  value = "${azurerm_container_group.vote-app.ip_address}"
}
```

```
terraform plan --out plan.out
```

Use `terraform apply plan.out` to apply the plan.

```
terraform apply plan.out
```

## Next Module

In the next module, you will learn about Terraform functions.

Module 5: [Terraform Functions](../5-terraform-functions)