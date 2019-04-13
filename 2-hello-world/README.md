# Terraform Hello World

## Module Overview

- Basic Terraform configuration
- Terraform Apply

## Create simple resource

Create simple resource, in this case an Azure Resource Group.

```
resource "azurerm_resource_group" "vote-resource-group" {
  name     = "vote-resource-group"
  location = "westus"
}
```