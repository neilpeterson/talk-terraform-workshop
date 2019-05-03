# Terraform and Cloud Native Application Bundles

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

## Create Terraform bundle

```
mkdir terraform-bundle
cd terraform-bundle
```

```
duffle init
```

```
git clone <insert>
cd <insert>
```

```
duffle build .
```

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


