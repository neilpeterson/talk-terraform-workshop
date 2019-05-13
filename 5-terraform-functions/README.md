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

Exit the Terraform console with the `exit` command.

```
exit
```

## Update container name to use lower function

Open the `main.tf` file created in the last module and update the name of the Azure Container Instance to use the `lower` function. If needed, you can create a new file and copy in the following configuration.

```
resource "azurerm_resource_group" "vote-app" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}

resource "azurerm_container_group" "vote-app" {
  name                = "${lower(var.container-name)}"
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

Because we have not updated the providers beeing used, we do not need to re-initalize the directory.

Create the deployment plan. If you have been following along, the container instance name should have changed from `HelloWorld` to `helloworld` which should be noted in the plan.

```
terraform plan --out plan.out
```

Use `terraform apply plan.out` to apply the plan.

```
terraform apply plan.out
```

The containers public IP address can be used to see the running application.

## Next Module

In the next module, you will learn about Terraform state.

Module 6: [Terraform State](../6-terraform-state)