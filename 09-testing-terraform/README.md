# Testing Terraform Configurations

## Module Overview

Just like with application code, the ability to test infrastructure code before committing to production enables effective continuous deployment. Unlike with application code, performing unit tests on infrastructure code is not simple. Integration testing, however, can be achieved using your own automation or one of many available packages.

In this module, you will perform an integration test on the hello world application using a well know package named Terratest. For more information on Terratest, see the [GitHub project](https://github.com/gruntwork-io/terratest).

## Terraform Tests with Terratest

Terratest is a go library, and such all tests are written in go lang. The workshop instructor will walk through the following sample.

```go
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
            strings.Contains(content, "Welcome")
    })
}
```

## Run the Tests

For this workshop, we have pre-created a modules repo with included tests. Go ahead and create a fork of this repository. This fork will be used in this workshop module and the next.

https://github.com/neilpeterson/terraform-modules.git

Navigate back to the root of your terraform directory and clone your modules fork into the directory. Update the following command with the address of your fork. Once done, change to the test directory.

```bash
git clone https://github.com/<update>/terraform-modules.git
cd terraform-modules/test/
```

Fetch the Terratest Go library.

```bash
go get github.com/gruntwork-io/terratest/modules/terraform
```

Now run all of the tests, which in this example is only one.

```bash
go test
```

This test will create the hello world application, validate that not only an HTTP status of 200 is returned but also that the returned body contains the text `welcome`. The deployment is then destroyed.

Once the test has completed, you should see output similar to the following.

```bash
PASS
ok      _/home/neil/clouddrive/terraform-modules/test   148.223s
```

## Next Module

In the next module, you will learn about automated integration testing of Terraform configurations in Azure Build Pipelines.

Module 10: [Continious Integration](../10-continuous-integration)
