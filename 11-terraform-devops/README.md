# Integrating with DevOps Pipelines

## Create an Azure DevOps instance

If needed, create an Azure DevOps instance. Azure DevOps is free for open source projects, including this workshop.

Navigate to [https://azure.microsoft.com/en-ca/services/devops/]() and sign up for a free account.

## Create configuration repository

Create a repository of Terraform configurations. For this example, we will fork the workshop repo. Navigate to [https://github.com/neilpeterson/talk-terraform-workshop](https://github.com/neilpeterson/talk-terraform-workshop) and fork the repo.

Clone the repo into your cloud shell instance. Update the URL with the address of your fork.

```
git clone https://github.com/<update>/talk-terraform-workshop.git
```

## Create DevOps project

## Create Build Pipeline

```
pool:
  name: Hosted Ubuntu 1604
steps:
- task: charleszipp.azure-pipelines-tasks-terraform.azure-pipelines-tasks-terraform-installer.TerraformInstaller@0
  displayName: 'Install Terraform on Build Agent'
  inputs:
    terraformVersion: 0.11.13

- script: 'terraform init -backend=false'
  displayName: 'Terraform Init'

- script: 'terraform validate'
  displayName: 'Terraform Validate'

- task: PublishPipelineArtifact@0
  displayName: 'Publish Terraform Artifacts'
  inputs:
    targetPath: .
```

## Next Module

In the next module, you will learn about deploying Terraform with Cloud Native Application Bundles.

Module 10: [Terraform and CNAB](../12-terraform-cnab)