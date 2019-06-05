# Terraform Modules

## Module Overview

Reusable code or functions are essential in effective coding. This holds true for infrastructure code as well. With Terraform we can package up a configuration into configuration modules for re-use. In this module, you will see how to re-use the hello world application as a Terraform module. For more information on Terraform module, see the [Terrform modules documentation](https://www.terraform.io/docs/configuration/modules.html).

## Create a Terraform module

Tricks on you, the configuration that we have been building is set up to function as a Terraform module. All Terraform configurations are Terraform modules.

To use the hello world configuration as a module, navigate one directory up from where the hello-world configuration is stored. Create a new directory named `hello-world-from-module`.

```
cd ../
mkdir hello-world-from-module
cd hello-world-from-module
```

Create a file name `main.tf` and add the following configuration. Notice here that instead of defining things like the container image, memory and cpu requests, and IP addressing configuration, we are only providing the location of the module, a resource group name, and a dns prefix. These values will be passed as input variables to the hello world configuration.

```
module "hello-world" {
    source = "../hello-world"
    resource_group = "hello-world-module"
    dns-prefix = "hello-world-module"
}
```

Run the `terraform init` command to initialize the directory.

```
terraform init
```

Create a terraform plan.

```
terraform plan --out plan.out
```

Apply the plan.

```
terraform apply plan.out
```

When complete, you will have another instance of the hello world application.

## Next Module

In the next module, you will learn about testing your Terraform configurations.

Module 9: [Testing Terraform](../09-testing-terraform)