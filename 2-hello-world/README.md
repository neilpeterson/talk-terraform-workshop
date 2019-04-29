# Terraform Hello World

## Module Overview

- Basic Terraform configuration
- Terraform init
- Terraform Apply

## Create simple resource

Create simple resource, in this case an Azure Resource Group.

Create a file named `main.tf` and copy in the following configuration.

```
resource "azurerm_resource_group" "hello-world" {
  name     = "hello-world"
  location = "westus"
}
```

Use `terraform init` to initalize the working directory.

```
terraform init
```

Use `terraform apply` to create the Azure Resource Group. Enter `yes` when prompted.

```
terraform apply
```

Use `terraform destroy` to remove the resource group. Enter `yes` when prompted.

```
terraform destroy
```