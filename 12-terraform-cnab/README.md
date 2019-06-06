# Cloud Native Application Bundles

## Module Overview

As we innovate and push the capability of cloud deployments, we are finding ourselves needing innovative tooling for deploying complex and cloud distributed applications to cloud resources. Our applications are no longer a single compiled package rather multiple packages, infrastructure components, policies, and control mechanisms. Some times these assets need to be deployed to multiple systems and potentially even multiple clouds. An emerging technology to address cloud deployments is Cloud Native Application Bundles (CNAB).

Cloud Native Application Bundles are a packaging format spec for cloud-based applications. CNAB bundles can be created, signed, stored in a container registry, and retrieved at deployment time. CNAB is just the packaging format. We also need tooling to create and manage bundles. For that, I introduce Porter the Cloud Installer.

NOTE: This module will not work in Azure Cloud Shell. To complete, you must have a system running Docker.

## Install Porter

Install Porter on your development system.

```
curl https://cdn.deislabs.io/porter/latest/install-mac.sh | bash
```

Add Porter to the path.

```
export PATH=$PATH:~/.porter
```

Install the Terraform mixin.

```
porter mixin install terraform --feed-url https://cdn.deislabs.io/porter/atom.xml
```

## Create Porter Bundle

Create a directory for your Porter bundle.

```
mkdir porter
cd porter
```

Bootstrap the Porter bundle.

```
porter create
```

Replace the contents of the `porter.yaml` file with this YAML.

```
mixins:
  - exec
  - terraform

name: hello-porter
version: 0.1.0
invocationImage: neilpeterson/hello-porter:latest

credentials:
  - name: subscription_id
    env: TF_VAR_subscription_id
  - name: tenant_id
    env: TF_VAR_tenant_id
  - name: client_id
    env: TF_VAR_client_id
  - name: client_secret
    env: TF_VAR_client_secret

parameters:
  - name: location
    type: string
    default: "East US"
    destination:
      env: TF_VAR_location

  - name: resource_group_name
    type: string
    default: "porterkvtest"
    destination:
      env: TF_VAR_resource_group_name

install:
  - terraform:
      description: "Install Hello World"
      autoApprove: true
      input: false

upgrade:
  - terraform:
      description: "Upgrade Hello World"
      autoApprove: true
      input: false

status:
  - terraform:
      description: "Get Hello World status"

uninstall:
  - terraform:
      description: "Uninstall Hello World"
      autoApprove: true
```


```
porter build
```

```
porter list
```