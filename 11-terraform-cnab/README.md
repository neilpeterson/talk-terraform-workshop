# Terraform and Cloud Native Application Bundles

## Module Overview

- Integration Terraform with Cloud Native application Bundles (CNAB)

## Install Duffle

- Go > 1.11.4
- make

```
go get -d github.com/deislabs/duffle/...
cd $(go env GOPATH)/src/github.com/deislabs/duffle
make bootstrap
make build
sudo make install
```

## Initilize Duffle and configure credentials

```
duffle init
```

Create a credentials file.

```
touch ~/.duffle/credentials/azure.json
```

Update the following with valid Azure credentials and copy into the credentials file.

```
credentials:
  - name: azureclientid
    source:
      value: "00000000-0000-0000-0000-000000000000"
  - name: azureclientsecret
    source:
      value: "00000000-0000-0000-0000-000000000000"
  - name: azuretenantid
    source:
      value: "00000000-0000-0000-0000-000000000000"
```

## Get the Terraform bundle

```
git clone https://github.com/neilpeterson/duffle-bundles.git
cd duffle-bundles/cnab-terraform-demo/
```

```
duffle build .
```

```
duffle bundle list

NAME               	VERSION	DIGEST
cnab-terraform-demo	0.1.0  	c5bc518ba370682abada3bfa85aa6075bebe6395
```

```
duffle install --credentials=azure cnab-terraform-demo cnab-terraform-demo:0.1.0
```

