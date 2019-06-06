# Approving and deploying Terraform configuration with Azure Pipelines

## Module Overview

In this module you will create an Azure release pipeline that will deploy the configurations to a 'test' environment, wait for human approval and then deploy the configuration to a 'production' environment.

## Create Release Pipeline

Create a new release pipeline. YAML based release pipelines are in preview and do not yet support manual approvals. We will work with classic pipelines for this workshop.

**Pipelines** > **Release** > **New Pipeline**

Start with an empty job pipeline template.

![](../images/empty-job.jpg)

Name the first stage `Test (Resource Group)`.

![](../images/stage-one.jpg)

Add the deployment artifacts created during the build. Take note of the **Source Alias**.

Select **Artifacts** > **Add** > **Build** > **terraform-modules-CI** > **Add**

![](../images/deployment-artifacts.jpg)

Select the test stage and then the parent task named `Agent job`.

Update the Agent pool to use `Hosted Ubuntu 1604` as the operating system for the build agent.

![](../images/build-agent.jpg)

Add a `Command Line` task, give it a name of `Terraform Deploy Test`, and copy in the following commands.

Update the first line to include the source alias gather in a previous step.

```
cd <source alias>/drop/modules/hello-world
terraform init
terraform plan --out plan.out
terraform apply plan.out
```

Finally, add Azure credentials to the deployment task.

Select **Variables** > **Link Variable Group** > **azure-credentials** > **Link**.

![](../images/link-variables.jpg)

Click back on **Tasks**. On the **Deploy Terraform Test**, expand **Environment Variables** and add each variable as seen in the following image.

![](../images/task-variables.jpg)

Click **Save** > **ok** > **Create Release** > and follow the prompts.

![](../images/release.jpg)

## Create a production stage with approval

Return to the release pipeline and clone the test stage.

![](../images/clone.jpg)

Update the stage and task name so that they indicate a production deployment.

![](../images/production.jpg)

Return to the pipeline and select pre-deployment conditions on the production stage.

![](../images/conditions.jpg)

Select **Pre-deployment approvals**, and add your account as an approver.

![](../images/approval.jpg)

Click **Save** and **Create Release** to start a new deployment.

## Next Module

In the next module, you will learn about deploying Terraform with Cloud Native Application Bundles.

Module 12: [Terraform and CNAB](../11-terraform-cnab)