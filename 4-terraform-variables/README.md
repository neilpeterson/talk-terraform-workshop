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
  default     = "vote-app"
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

## Update configuration to use variables

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

# Run the updated configuration

```
terraform plan --out plan.out
```

Notice that the previous deployment was found, however, the Container Instance name has changed, which requires the resource to be re-deployed.

```
-/+ azurerm_container_group.vote-app (new resource required)
      id:                     "/subscriptions/3762d87c-ddb8-425f-b2fc-29e5e859edaf/resourceGroups/vote-app/providers/Microsoft.ContainerInstance/containerGroups/vote-app" => <computed> (forces new resource)
      container.#:            "1" => "1"
      container.0.command:    "" => <computed>
      container.0.commands.#: "0" => <computed>
      container.0.cpu:        "0.5" => "0.5"
      container.0.image:      "microsoft/aci-helloworld" => "microsoft/aci-helloworld"
      container.0.memory:     "1.5" => "1.5"
      container.0.name:       "vote-app" => "vote-app"
      container.0.port:       "80" => "80"
      container.0.ports.#:    "1" => <computed>
      dns_name_label:         "vote-app" => "vote-app"
      fqdn:                   "vote-app.eastus.azurecontainer.io" => <computed>
      identity.#:             "0" => <computed>
      ip_address:             "52.191.238.58" => <computed>
      ip_address_type:        "Public" => "public"
      location:               "eastus" => "eastus"
      name:                   "vote-app" => "HelloWorld" (forces new resource)
      os_type:                "Linux" => "linux"
      resource_group_name:    "vote-app" => "vote-app"
      restart_policy:         "Always" => "Always"
      tags.%:                 "0" => <computed>
```

Use `terraform apply plan.out` to apply the plan.

```
terraform apply plan.out
```

Once the deployment has compelted, the output variable is displayed.

```
Outputs:

ip_address = 52.224.145.193
```

The containers public IP address can be used to see the running application.

## Next Module

In the next module, you will learn about Terraform functions.

Module 5: [Terraform Functions](../5-terraform-functions)