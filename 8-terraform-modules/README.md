# Terraform Modules

## Module Overview

- Reusing Terraform configurations as modules
- Storing Terraform modules in a module registry

## Create a Terraform module

Navigate one directory up from where the vote-app configuration is stored. Create a new directory named `vote-app-from-module`.

```
cd ../
mkdir vote-app-from-module
cd vote-app-from-module
```

Create a file name `main.tf` and add the following configuration.

```
module "vote-app" {
    source = "../vote-app"
    resource_group = "vote-app-module"
    location = "eastus"
    dns-prefix = "vote-app-module"
    container-image = "microsoft/azure-vote-front:cosmosdb"
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

## Next Module

In the next module, you will learn about Terraform datasources and templates.

Module 9: [Terraform Datasources and Templates](../9-datasources-templates)
