# Terraform Modules

## Module Overview

Reusable code or functions are essential in effective coding. This holds true for infrastructure code as well. With Terraform you can package up a configuration into configuration modules for re-use.

In this module, you will see how to re-use the hello world configuration as a Terraform module.

## Create a Terraform module

To use the hello world configuration as a module, navigate back to the root of `terraform` directory that you created earlier in this workshop. Create a new directory named `hello-world-from-module`.

```bash
mkdir hello-world-from-module
cd hello-world-from-module
```

Create a file named `main.tf`.

```bash
touch main.tf
```

Copy in the following configuration.

Notice here that instead of defining things like the container image, memory, and cpu requests, you are only providing the location of the module, a resource group name, and a dns prefix. These values will be passed as input variables to the hello world configuration.

```terraform
module "hello-world" {
    source = "../hello-world"
    resource_group = "hello-world-module"
    dns-prefix = "hello-world-module"
}
```

Run the `terraform init` command to initialize the directory.

```bash
terraform init
```

Create a terraform plan.

```bash
terraform plan --out plan.out
```

Apply the plan.

```bash
terraform apply plan.out
```

When complete, you will have another instance of the hello world application.

## Next Module

In the next module, you will learn about testing your Terraform configurations.

Module 9: [Testing Terraform](../09-testing-terraform)
