# Integrating with Azure Pipelines

## Module Overview

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
terraform init
terraform workspace select hello-world-test-environment || terraform workspace new hello-world-test-environment
terraform init
```

Add a `Command Line` task, give it a name of `Terraform Apply`, and copy in the following commands:

```
cd _terraform-modules-CI/drop/modules/hello-world
terraform apply plan.out
```

Finally, because the variables are encrypted, we need to specify each one as an environment variable on the task that will consume this. Click back on the pipeline, select the **Terraform Apply** task, expand **Environment Variables**, and add each variable as seen in the following image.

![](../images/task-variables.jpg)

Click **Save** > **ok** > **Create Release** > and follow the prompts.

![](../images/release.jpg)

## Create a produciton stage with approval

## Next Module

In the next module, you will learn about deploying Terraform with Cloud Native Application Bundles.

Module 12: [Terraform and CNAB](../11-terraform-cnab)