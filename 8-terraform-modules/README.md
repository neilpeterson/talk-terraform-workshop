# Terraform Modules

## Module Overview

- Reusing Terraform configurations as modules
- Storing Terraform modules in a module registry

## Create a Terraform module

Navigate one directory up from where the hello-world configuration is stored. Create a new directory named `hello-world-from-module`.

```
cd ../
mkdir hello-world-from-module
cd hello-world-from-module
```

Create a file name `main.tf` and add the following configuration.

```
module "hello-world" {
    source = "../hello-world"
    resource_group = "hello-world-module"
    dns-prefix = "hello-world-module"
}
```

```
terraform init
```

```
terraform plan --out plan.out
```

```
terraform apply plan.out
```

## Use exsisting Terrafrom Module

## Next Module

In the next module, you will learn about Terraform datasources and templates.

Module 9: [Testing Terraform](../9-testing-terraform)
