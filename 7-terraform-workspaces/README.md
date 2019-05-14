# Terraform Workspaces

## Module Overview

- Configure multiple workspaces
- Workspace interpolation
- Workspaces on the backend

```
terraform workspace list
```

```
terraform workspace new demo-workspace-001
```

```
resource "azurerm_resource_group" "vote-app" {
  name     = "${var.resource_group}-${terraform.workspace}"
  location = "${var.location}"
}

resource "azurerm_container_group" "vote-app" {
  name                = "${lower(var.container-name)}"
  location            = "${azurerm_resource_group.vote-app.location}"
  resource_group_name = "${azurerm_resource_group.vote-app.name}"
  ip_address_type     = "public"
  dns_name_label      = "${var.dns-prefix}-${terraform.workspace}"
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

```
terraform plan --out plan.out
```

```
terraform apply plan.out
```

![](../images/workspace-backend.jpg)

## Next Module

In the next module, you will learn about Terraform modules.

Module 8: [Terraform Modules](../8-terraform-modules)