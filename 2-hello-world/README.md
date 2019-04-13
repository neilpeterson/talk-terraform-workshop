# Terraform Hello World

## Module Overview

- Basic Terraform configuration
- Terraform init
- Terraform Apply

## Create simple resource

Create simple resource, in this case an Azure Resource Group.

Create a file named `main.tf` and copy in the following configuration.

```
resource "azurerm_resource_group" "vote-resource-group" {
  name     = "vote-resource-group"
  location = "westus"
}
```

Use `terraform init` to initalize the working directory.

```
$ terraform init

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.azurerm: version = "~> 1.24"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Use `terraform apply` to create the Azure Resource Group.

```
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + azurerm_resource_group.vote-resource-group
      id:       <computed>
      location: "westus"
      name:     "vote-resource-group"
      tags.%:   <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

Enter `yes` when prompted.

```
azurerm_resource_group.vote-resource-group: Creating...
  location: "" => "westus"
  name:     "" => "vote-resource-group"
  tags.%:   "" => "<computed>"
azurerm_resource_group.vote-resource-group: Creation complete after 1s (ID: /subscriptions/3762d87c-ddb8-425f-b2fc-...daf/resourceGroups/vote-resource-group)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```