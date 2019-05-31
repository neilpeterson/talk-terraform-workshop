# Integrating with DevOps Pipelines

## Create an Azure DevOps instance

If needed, create an Azure DevOps instance. Azure DevOps is free for open source projects, including this workshop.

Navigate to [https://azure.microsoft.com/en-ca/services/devops/](https://azure.microsoft.com/en-ca/services/devops/?WT.mc_id=cloudnativeterraform-github-nepeters) and sign up for a free Azure DevOps organization.

![](../images/azd-one.jpg)

Once you have created the organization, a DevOps project is automatically created for you. The DevOps project is where you can create and manage Azure Boards, Azure Repositories, and Azure Pipelines. We will come back to the organization and work with Pipelines later in this module.

## Create configuration repository

Create a repository of Terraform configurations. For this example, we will fork the workshop repo. Navigate to [https://github.com/neilpeterson/terraform-devops-samplep](https://github.com/neilpeterson/terraform-devops-sample) and fork the repo.

Clone the repo into your cloud shell instance. Update the URL with the address of your fork.

```
git clone https://github.com/<replace>/terraform-devops-sample.git
```

## Create Build Pipeline

Pipelines > Build > New Pipeline > GitHub (YAML)

Select the GitHub repository that contains the Terraform configuraions

Approve and install the Azure Pipelines > GitHub integration

Exsisting Azure Pipelines YAML file

Path > pipeline.yaml

## Create Release Pipline

Pipelines > Release > New Pipeline

Start with an empty job

Name first stage `Test (Resource Group)`

Add a `Command Line` task, give it a name of `Install Terraform on Release Agent`, and copy in the following script:

```
ENV TERRAFORM_VERSION=0.11.13
apt-get install unzip
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_0.11.13_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

## Next Module

In the next module, you will learn about deploying Terraform with Cloud Native Application Bundles.

Module 10: [Terraform and CNAB](../11-terraform-cnab)