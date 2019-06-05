# Integrating with Azure Pipelines

## Create configuration repository

Create a repository of Terraform configurations. For this example, we will fork the workshop repo. Navigate to [https://github.com/neilpeterson/terraform-modules.git](https://github.com/neilpeterson/terraform-modules.git) and fork the repo.

Clone the repo into your cloud shell instance. Update the URL with the address of your fork.

```
git clone https://github.com/<replace>/terraform-devops-sample.git
```

## Create an Azure DevOps instance

If needed, create an Azure DevOps instance. Azure DevOps is free for open source projects, including this workshop.

Navigate to [https://azure.microsoft.com/en-ca/services/devops/](https://azure.microsoft.com/en-ca/services/devops/?WT.mc_id=cloudnativeterraform-github-nepeters) and sign up for a free Azure DevOps organization.

![](../images/azd-one.jpg)

Once you have created the organization, you will be prompted to create a new project. The DevOps project is where you can create and manage Azure Boards, Azure Repositories, and Azure Pipelines.

![](../images/new-project.jpg)

## Create Build Pipeline

Create a new build pipeline.

*Pipelines* > *Build* > *New Pipeline* > *GitHub (YAML)*

![](../images/github-yaml.jpg)

Select the GitHub repository that contains the Terraform configurations

![](../images/select-repo.jpg)

Approve and install the Azure Pipelines > GitHub integration

![](../images/authorize.jpg)

Existing Azure Pipelines YAML file

![](../images/pipeline-type.jpg)

*Path* > *build-pipeline.yaml*

![](../images/path.jpg)

At this point, the pipeline should have been imported.

![](../images/pipeline.jpg)

Click the **Run** button to kick off the initial build.

....unfortunately the build will fail.

## Add Azure Credentials

In order for you to run terratest integration test, you will need to provide credentials to the pipeline.

First, use the Azure CLI [az ad sp create-for-rback]() command to create an Azure Service Principal. Take note of each value, these will be added to the pipeline.

NOTE: This operation created an account with admin access to your Azure subscription. Take care to secure the credentials and see [this article] for more information on limiting the scope of this account.

```
$ az ad sp create-for-rbac

{
  "appId": "3026b3e5-000-000-0000-3497c48fbee1",
  "displayName": "azure-cli-2019-06-05-06-16-20",
  "name": "http://azure-cli-2019-06-05-06-16-20",
  "password": "48005028-0000-0000-0000-f6063e5e3a1f",
  "tenant": "72f988bf-0000-0000-0000-2d7cd011db47"
}
```

You will also need your Azure subscription id. Use the [az account list] command to find this value.

```
$ az account list -o table

Name                                         CloudName    SubscriptionId                        State    IsDefault
-------------------------------------------  -----------  ------------------------------------  -------  -----------
ca-nepeters-demo-test                        AzureCloud   3000087c-0000-0000-0000-29e5e0000daf  Enabled  True
```

You will also need to gather the storage account key for the terraform state backend. This can be found in the Azure portal, or by using the [az storage account keys list]() command

![](../images/storage-key.jpg)

Back in the Azure Pipeline, click *Builds* > *Edit*. Click on the ellipsis near the top left hand and click *Variables*.

![](../images/variables.jpg)

Add the following variables, encrypting each one with the lock button.

ARM_ACCESS_KEY: Storage account key for the state backend.
ARM_CLIENT_ID: The service principal appId.
ARM_CLIENT_SECRET: The service principal password.
ARM_TENANT_ID: The tenant id which can be found with the service principal information.
ARM_SUBSCRIPTION_ID: The Azure subscription id.

![](../images/encrypted-variables.jpg)

## Create Release Pipeline

Create a new release pipeline. YAML based release pipelines are in preview and do not yet support manual approvals, so we will work with classic pipelines for this workshop.

**Pipelines** > **Release** > **New Pipeline**

Start with an empty job pipeline template.

![](../images/empty-job.jpg)

Name the first stage `Test (Resource Group)`. We will add a production stage later in this module.

![](../images/stage-one.jpg)

Add the deployment artifacts created during the build.

Select **Artifacts** > **Add** > **Build** > **terraform-modules-CI** > **Add**

![](../images/deployment-artifacts.jpg)

Select the stage to edit the stage tasks.

Select the parent task named `Agent job` and update the Agent pool to use `Hosted Ubuntu 1604` as the operating system for the build agent.

![](../images/build-agent.jpg)

Add a `Command Line` task, give it a name of `Terraform Init`, and copy in the following commands:

```
cd _terraform-modules-CI/drop/modules/hello-world
terraform init
```

Add a `Command Line` task, give it a name of `Terraform Plan`, and copy in the following commands:

```
cd _terraform-modules-CI/drop/modules/hello-world
terraform plan --out plan.out
```

Add a `Command Line` task, give it a name of `Terraform Apply`, and copy in the following commands:

```
cd _terraform-modules-CI/drop/modules/hello-world
terraform plan --out plan.out --var resource_group=hello-world-test-$(Build.BuildId)
```

The last step is to configure credentials that have access to create Azure resources. For this step, we will create an Azure service principal and store the values in encrypted Azure DevOps variables.

## Next Module

In the next module, you will learn about deploying Terraform with Cloud Native Application Bundles.

Module 10: [Terraform and CNAB](../11-terraform-cnab)