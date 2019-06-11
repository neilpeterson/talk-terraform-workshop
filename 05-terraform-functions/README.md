# Terraform Functions

## Module Overview

Terraform functions allow us to transform, manipulate, and combine strings of text. This is useful for instance when wanting to control the CASING of a resource name.

## Use the Terraform console

Terraform includes a built-in console for testing Terraform function syntax. Start the console with the `terraform console` command.

```bash
terraform console
```

Enter the following to run the `lower` function on the string `HELLO`).

```bash
lower("HELLO")
```

Enter the following to run the `substr` function on the long string.

```bash
substr("ThisIsALongStfunctions-demongThatWouldFailAsAnAzureStorageAccountName", 0, 6)
```

The following example combines both the `lower` and `substr` functions.

```bash
lower(substr("ThisIsALongStfunctions-demongThatWouldFailAsAnAzureStorageAccountName", 0, 6))
```

Exit the Terraform console with the `exit` command.

```bash
exit
```

## Update container name

Open the `main.tf` file created in the last module and update the name of the Azure Container Instance to use the `lower` function.

```terraform
resource "azurerm_resource_group" "hello-world" {
  name     = var.resource_group
  location = var.location
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_container_group" "hello-world" {
  name                = lower(var.container-name)
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

Create the deployment plan.

```bash
terraform plan --out plan.out
```

If you have been following along, the container instance name should have changed from `HelloWorld` to `helloworld` which should be noted in the plan (output below).

```terraform
# azurerm_container_group.hello-world must be replaced
-/+ resource "azurerm_container_group" "hello-world" {
        dns_name_label      = "hello-world-71849"
      ~ fqdn                = "hello-world-71849.eastus.azurecontainer.io" -> (known after apply)
      ~ id                  = "/subscriptions/3762d87c-ddb8-425f-b2fc-29e5e859edaf/resourceGroups/hello-world/providers/Microsoft.ContainerInstance/containerGroups/HelloWorld" -> (known after apply)
      ~ ip_address          = "52.224.150.48" -> (known after apply)
      ~ ip_address_type     = "Public" -> "public"
        location            = "eastus"
      ~ name                = "HelloWorld" -> "helloworld" # forces replacement
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

The containers FQDN can be used to see the running application.

## Next Module

In the next module, you will learn about Terraform state.

Module 6: [Terraform State](../06-terraform-state)
