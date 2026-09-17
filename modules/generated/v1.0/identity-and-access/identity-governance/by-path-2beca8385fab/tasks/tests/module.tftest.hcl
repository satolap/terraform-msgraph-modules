# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    workflow_id                     = "test-parent-id"
    workflow_version_version_number = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/lifecycleWorkflows/deletedItems/workflows/test-parent-id/versions/test-parent-id/tasks"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["arguments", "category", "continueOnError", "description", "displayName", "executionSequence", "isEnabled", "taskDefinitionId", "taskProcessingResults"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    workflow_id                     = "test-parent-id"
    workflow_version_version_number = "test-parent-id"
    category                        = "joiner"
    continue_on_error               = false
    execution_sequence              = -2147483648
    arguments                       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["category"]) == jsonencode("joiner")
    error_message = "category must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["continueOnError"]) == jsonencode(false)
    error_message = "continueOnError must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["executionSequence"]) == jsonencode(-2147483648)
    error_message = "executionSequence must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["arguments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.keyValuePair" }])
    error_message = "arguments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    workflow_id                     = "test-parent-id"
    workflow_version_version_number = "test-parent-id"
    category                        = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.category]
}
