# Terraform Hello World

## Module Overview

- Basic Terraform configuration
- Terraform init
- Terraform Apply

## Create a simple Terraform configuration

A Terraform configuration is a file or set of files that declare the resource to be created. We will start with a single file, however as the workshop progresses, this will expand to include multiple files. Terraform configuration are written in Hashicopr Configuration Language (HCL) or JSON. Fro this workshop we will work exclusively in HCL. For detailed specs on HCL, see [Terraform Configuration Language](https://www.terraform.io/docs/configuration/index.html).

Create a file named `main.tf` and copy in the following configuration. This configuration includes a single resource block that creates an Azure Resource Group.

```
resource "azurerm_resource_group" "hello-world" {
  name     = "hello-world"
  location = "westus"
}
```

Before creating the resource with Terraform, the current working directory must be initialized. The initialization process ensures that the proper Terraform provider plugins, Azure, in this case, have been downloaded.

Use `terraform init` to initialize the working directory.

```
terraform init
```

Once the directory has been initialized, the configuration can be run. Use the `terraform apply` command to run the configuration. Terraform will produce a plan that indicates all resources that will be created, modified, or destroyed. You can then accept the plan to created the resources. As this workshop progresses, we will see multiple methods for creating a Terraform plan.

Use `terraform apply` to create the Azure Resource Group. Enter `yes` when prompted.

```
terraform apply
```

Now that the Terraform configuration has been applied, the configuration can also be destroyed using the `terraform destroy` command.

Use `terraform destroy` to remove the resource group. Enter `yes` when prompted.

```
terraform destroy
```

## Next Module

In the next module, you will learn about many core Terraform concepts.

Module 3: [Terraform Core Concepts](../3-core-concepts)