# Testing Terraform Configurations

## Terraform Tests with Terratest

```
package test

import (
    "fmt"
    "strings"
    "testing"

    "github.com/gruntwork-io/terratest/modules/http-helper"
    "github.com/gruntwork-io/terratest/modules/random"
    "github.com/gruntwork-io/terratest/modules/terraform"
)

func TestHelloWorld(t *testing.T) {
    t.Parallel()

    // Generate a random DSN name to prevent a naming conflict
    uniqueID := random.UniqueId()
    uniqueName := fmt.Sprintf("Hello-World-%s", uniqueID)

    // Specify the test case folder and "-var" options
    terraformOptions := &terraform.Options{
        TerraformDir: "../modules/hello-world/",
        Vars: map[string]interface{}{
            "resource_group": uniqueName,
            "dns-prefix":     uniqueName,
        },
    }

    // Terraform init, apply, output, and destroy
    defer terraform.Destroy(t, terraformOptions)
    terraform.InitAndApply(t, terraformOptions)

    // Get Application URL from output
    fqdn := terraform.Output(t, terraformOptions, "fqdn")
    query := fmt.Sprintf("http://%s", fqdn)

    // Validate the provisioned application
    http_helper.HttpGetWithCustomValidation(t, query, func(status int, content string) bool {
        return status == 200 &&
            strings.Contains(content, "Hello")
    })
}
```

## Run the Tests

Navigate back to the root of the Azure Cloud Shell drive.

```
cd ~/clouddrive
```

Clone the sample modules repository and set up the Go dependancies.

```
git clone https://github.com/neilpeterson/terraform-modules.git
cd terraform-modules/test/
go get github.com/gruntwork-io/terratest/modules/terraform
```

Now run all of the tests, which in this example is only one.

```
go test
```

This test will create the hello world application, validate that not only an HTTP status of 200 is returned but also that the returned body contains the text `welcome`. The deployment is then destroyed.

Once the test has completed, you should see output similar to the following.

```
PASS
ok      _/home/neil/clouddrive/terraform-modules/test   148.223s
```

## Next Module

In the next module, you will learn about testing and running Terraform configurations from CI/CD pipelines.

Module 11: [Terraform and CI/CD pipelines](../10-terraform-devops)