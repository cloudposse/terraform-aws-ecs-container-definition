package test

import (
	"testing"

	"encoding/json"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-east-2.tfvars"},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	jsonMap := terraform.OutputRequired(t, terraformOptions, "json_map_encoded")

	// Verify we're getting back the outputs we expect
	var jsonObject map[string]interface{}
	err := json.Unmarshal([]byte(jsonMap), &jsonObject)
	assert.NoError(t, err)

	assert.Equal(t, "app", jsonObject["name"])
	assert.Equal(t, "cloudposse/geodesic", jsonObject["image"])
	assert.Equal(t, 256, int((jsonObject["memory"]).(float64)))
	assert.Equal(t, 128, int((jsonObject["memoryReservation"]).(float64)))
	assert.Equal(t, 256, int((jsonObject["cpu"]).(float64)))
	assert.Equal(t, true, jsonObject["essential"])
	assert.Equal(t, false, jsonObject["readonlyRootFilesystem"])
	assert.Equal(t, true, jsonObject["skip_destroy"])

	// Run `terraform output` to compare the expected container definition with the actual aws_ecs_task_definition container definition
	containerDefinitionExpected := terraform.OutputRequired(t, terraformOptions, "json_map_object")
	containerDefinition := terraform.OutputRequired(t, terraformOptions, "task_definition_container_definition")
	assert.Equal(t, containerDefinitionExpected, containerDefinition)
}
