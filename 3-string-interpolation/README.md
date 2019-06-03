# String Interpolation

## Module Overview

- String Interpolation
- Terraform Plan

## Update configuration to include a Container Instance resource

Open the previously created configuration found in the main.tf file. The contents should match the following. If needed, recreate the file.

```
resource "azurerm_resource_group" "hello-world" {
  name     = "hello-world"
  location = "eastus"
}
```

We now want to add an Azure Container Instance to the configuration. The trick is though that we want the resource created inside of the resource group that is also defined in the configuration. To do so we need the resource group, which can be derived using a process referred to as string interpolation.

Update the configuration so that it looks like this.

```
resource "azurerm_resource_group" "hello-world" {
  name     = "hello-world"
  location = "eastus"
}

resource "azurerm_container_group" "hello-world" {
  name                = "hello-world"
  location            = "${azurerm_resource_group.hello-world.location}"
  resource_group_name = "${azurerm_resource_group.hello-world.name}"
  ip_address_type     = "public"
  dns_name_label      = "${azurerm_resource_group.hello-world.name}"
  os_type             = "linux"

  container {
    name   = "hello-world"
    image  = "microsoft/aci-helloworld"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port   = 80
      protocol ="TCP"
    }
  }
}
```

Notice that a second configuration block is defined for the Azure Container Instances (azurerm_resource_group). Also notice the syntax that makes up the container instance location, resource_group_name, and dns_name_label. The values are derived from the azure_resoure_group using the notation `${azurerm_resource_group.hello-world.name}`.

## Apply the configuration

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

You can validate that the container has been created using the Azure CLI `az contaier list` command.

```
az container list -o table

Name      ResourceGroup    Status     Image                     IP:ports          Network    CPU/Memory       OsType    Location
--------  ---------------  ---------  ------------------------  ----------------  ---------  ---------------  --------  ----------
hello-world  hello-world         Succeeded  microsoft/aci-helloworld  52.191.238.58:80  Public     0.5 core/1.5 gb  Linux     eastus
```

The containers public IP address can be used to see the running application.

![](../images/aci-hello-world.jpg)

## Next Module

In the next module, you will learn about adding both input and output variables to a Terraform configuration.

Module 4: [Terraform Variables](../4-terraform-variables)