# Terraform Variables

## Module Overview

Terraform input variables are used to parameterize Terraform configurations. Output variables are used to return data after a Terraform configuration has been run.

In this module, you will update the hello world configuration to consume a set of variables and to also output the FQDN of the container instance.

## Create variables file

Create a new file named `variables.tf`.

```
touch variables.tf
```

copy in the following configurations. These input variables are used to pass parameter values into the deployment configuration.

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

Update the configuration so that it consumes each variable.

```
resource "azurerm_resource_group" "hello-world" {
  name     = var.resource_group
  location = var.location
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_container_group" "hello-world" {
  name                = var.container-name
  location            = azurerm_resource_group.hello-world.location
  resource_group_name = azurerm_resource_group.hello-world.name
  ip_address_type     = "public"
  dns_name_label      = "${var.dns-prefix}-${random_integer.ri.result}"
  os_type             = "linux"

  container {
    name   = "hello-world"
    image  = var.container-image
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port      = 80
      protocol  = "TCP"
    }
  }
}
```

Notice that the resource group name, location, and the container instance name and FQDN values are all derived from an input variable.

## Output Variables

Output variables can be used to output calculated values to the terminal and also for passing data between Terraform modules. We will discuss modules later on in this workshop.

Create a file named `outputs.tf` for the output variables.

```
touch outputs.tf
```

Copy in the following configuration. This configuration will output the fully qualified domain name (FQDN) of the container instance.

```
output "fqdn" {
  value = azurerm_container_group.hello-world.fqdn
}
```

# Run the updated configuration

```
terraform plan --out plan.out
```

Notice that the previous deployment was found, however, the Container Instance name has changed, which requires the resource to be re-deployed.

```
Terraform will perform the following actions:

  # azurerm_container_group.hello-world must be replaced
-/+ resource "azurerm_container_group" "hello-world" {
        dns_name_label      = "hello-world-71849"
      ~ fqdn                = "hello-world-71849.eastus.azurecontainer.io" -> (known after apply)
      ~ id                  = "/subscriptions/00000000-0000-0000-0000-00000000/resourceGroups/hello-world/providers/Microsoft.ContainerInstance/containerGroups/hello-world" -> (known after apply)
      ~ ip_address          = "52.226.136.152" -> (known after apply)
      ~ ip_address_type     = "Public" -> "public"
        location            = "eastus"
      ~ name                = "hello-world" -> "HelloWorld" # forces replacement
      ~ os_type             = "Linux" -> "linux"
        resource_group_name = "hello-world"
        restart_policy      = "Always"
      ~ tags                = {} -> (known after apply)

      ~ container {
          + command                      = (known after apply)
          ~ commands                     = [] -> (known after apply)
            cpu                          = 0.5
          - environment_variables        = {} -> null
            image                        = "microsoft/aci-helloworld"
            memory                       = 1.5
            name                         = "hello-world"
          ~ port                         = 80 -> (known after apply)
          ~ protocol                     = "TCP" -> (known after apply)
          - secure_environment_variables = (sensitive value)

            ports {
                port     = 80
                protocol = "TCP"
            }
        }

      + identity {
          + identity_ids = (known after apply)
          + principal_id = (known after apply)
          + type         = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 1 to destroy.
```

Use `terraform apply plan.out` to apply the plan.

```
terraform apply plan.out
```

Once the deployment has completed, the output variable is displayed.

```
Outputs:

fqdn = hello-world-58716.eastus.azurecontainer.io
```

The containers FQDN can be used to access the running application.

## Next Module

In the next module, you will learn about Terraform functions.

Module 5: [Terraform Functions](../05-terraform-functions)