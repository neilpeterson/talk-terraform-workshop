# Terraform Functions

## Module Overview

Terraform functions allow us to transform, manipulate, and combine strings of text. This is useful for instance when wanting to control the CASING of a resource name.

## Use the Terraform console

Terraform includes a built-in console for testing Terraform function syntax. Start the console with the `terraform console` command.

```
terraform console
```

Enter the following to run the `lower` function on the string `HELLO`).

```
lower("HELLO")
```

Enter the following to run the `substr` function on the long string.

```
substr("ThisIsALongStfunctions-demongThatWouldFailAsAnAzureStorageAccountName", 0, 6)
```

The following example combines both the `lower` and `substr` functions.

```
lower(substr("ThisIsALongStfunctions-demongThatWouldFailAsAnAzureStorageAccountName", 0, 6))
```

Exit the Terraform console with the `exit` command.

```
exit
```

## Update container name

Open the `main.tf` file created in the last module and update the name of the Azure Container Instance to use the `lower` function.

```
resource "azurerm_resource_group" "hello-world" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_container_group" "hello-world" {
  name                = "${lower(var.container-name)}"
  location            = "${azurerm_resource_group.hello-world.location}"
  resource_group_name = "${azurerm_resource_group.hello-world.name}"
  ip_address_type     = "public"
  dns_name_label      = "${var.dns-prefix}-${random_integer.ri.result}"
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

Create the deployment plan. If you have been following along, the container instance name should have changed from `HelloWorld` to `helloworld` which should be noted in the plan.

```
$ terraform plan --out plan.out

-/+ azurerm_container_group.hello-world (new resource required)
      id:                     "/subscriptions/3762d87c-ddb8-425f-b2fc-29e5e859edaf/resourceGroups/hello-world/providers/Microsoft.ContainerInstance/containerGroups/HelloWorld" => <computed> (forces new resource)
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
      ip_address:             "52.224.145.193" => <computed>
      ip_address_type:        "Public" => "public"
      location:               "eastus" => "eastus"
      name:                   "HelloWorld" => "helloworld" (forces new resource)
      os_type:                "Linux" => "linux"
      resource_group_name:    "hello-world" => "hello-world"
      restart_policy:         "Always" => "Always"
      tags.%:                 "0" => <computed>
```

Use `terraform apply plan.out` to apply the plan.

```
terraform apply plan.out
```

The containers FQDN can be used to see the running application.

## Next Module

In the next module, you will learn about Terraform state.

Module 6: [Terraform State](../06-terraform-state)