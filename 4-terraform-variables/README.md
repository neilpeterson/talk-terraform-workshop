# Terraform Variables

## Module Overview

- Input variables
- Output variables

## Create variables file

Create a new file named `variables.tf`. This file will hold variables and default variable values that can be used in your Terraform configurations. A separate file for variables is optional. Variables can also be defined in the same files as your Terraform configurations.

```
touch variables.tf
```

Add these four variables.

```
variable "resource_group" {
  description = "The name of the resource group in which to create the container instance and Cosmos DB instance."
  default     = "hello-world"
}

variable "location" {
  description = "The location for the resource group in which to create the container instance and Cosmos DB instance."
  default     = "eastus"
}

variable "dns-prefix" {
  description = "DNS prefix for the public IP address of the container instance."
  default     = "hello-world"
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

Update the configuration so that it consums each variable. The syntax (pre 0.12.0) is `${var.variable-name}`. For post 0.12.0 syntax, swith to the [0.12.0 version of this workshop](./replace).


```
resource "azurerm_resource_group" "hello-world" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}

resource "azurerm_container_group" "hello-world" {
  name                = "${var.container-name}"
  location            = "${azurerm_resource_group.hello-world.location}"
  resource_group_name = "${azurerm_resource_group.hello-world.name}"
  ip_address_type     = "public"
  dns_name_label      = "${var.dns-prefix}"
  os_type             = "linux"

  container {
    name   = "hello-world"
    image  = "${var.container-image}"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port      = 80
      protocol  = "TCP"
    }
  }
}
```

Output variables can be used to output calculated values to the terminal and also for passing data between Terraform modules. We will discuss modules later on in this workshop.

Create a file named `outputs.tf` for the output variables.

```
touch outputs.tf
```

Copy in the following configuration. This configuration will output the public IP address of the container instance.

```
output "ip_address" {
  value = "${azurerm_container_group.hello-world.ip_address}"
}
```

# Run the updated configuration

```
terraform plan --out plan.out
```

Notice that the previous deployment was found, however, the Container Instance name has changed, which requires the resource to be re-deployed.

```
-/+ azurerm_container_group.hello-world (new resource required)
      id:                     "/subscriptions/3762d87c-ddb8-425f-b2fc-29e5e859edaf/resourceGroups/hello-world/providers/Microsoft.ContainerInstance/containerGroups/hello-world" => <computed> (forces new resource)
      container.#:            "1" => "1"
      container.0.command:    "" => <computed>
      container.0.commands.#: "0" => <computed>
      container.0.cpu:        "0.5" => "0.5"
      container.0.image:      "microsoft/aci-helloworld" => "microsoft/aci-helloworld"
      container.0.memory:     "1.5" => "1.5"
      container.0.name:       "hello-world" => "hello-world"
      container.0.port:       "80" => "80"
      container.0.ports.#:    "1" => <computed>
      dns_name_label:         "hello-world" => "hello-world"
      fqdn:                   "hello-world.eastus.azurecontainer.io" => <computed>
      identity.#:             "0" => <computed>
      ip_address:             "52.191.238.58" => <computed>
      ip_address_type:        "Public" => "public"
      location:               "eastus" => "eastus"
      name:                   "hello-world" => "HelloWorld" (forces new resource)
      os_type:                "Linux" => "linux"
      resource_group_name:    "hello-world" => "hello-world"
      restart_policy:         "Always" => "Always"
      tags.%:                 "0" => <computed>
```

Use `terraform apply plan.out` to apply the plan.

```
terraform apply plan.out
```

Once the deployment has completed, the output variable is displayed.

```
Outputs:

ip_address = 52.224.145.193
```

The containers public IP address can be used to access the running application.

## Next Module

In the next module, you will learn about Terraform functions.

Module 5: [Terraform Functions](../5-terraform-functions)