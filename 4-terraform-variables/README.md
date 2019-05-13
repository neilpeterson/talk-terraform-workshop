# Terraform Variables

## Module Overview

- Input variables
- Output variables

## Create variables file

```
touch variables.tf
```

```
variable "resource_group" {
  description = "The name of the resource group in which to create the container instance and Cosmos DB instance."
  default     = "vote-app"
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
  default     = "microsoft/aci-helloworld"
}

variable "container-name" {
  description = "Container image for the Azure Vote Flask application."
  default     = "HelloWorld"
}
```

## Add a Microsoft Azure Consmos Database

```
resource "azurerm_resource_group" "vote-app" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}

resource "azurerm_container_group" "vote-app" {
  name                = "${var.container-name}"
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
  }
}
```

Add output variable to surface ip address.

```
touch output.tf
```

```
output "ip_address" {
  value = "${azurerm_container_group.vote-app.ip_address}"
}
```

```
terraform init
```

```
terraform plan --out plan.out
```

Use `terraform apply plan.out` to apply the plan.

```
terraform apply plan.out
```

The containers public IP address can be used to see the running application.

## Next Module

In the next module, you will learn about Terraform functions.

Module 5: [Terraform Functions](../5-terraform-functions)