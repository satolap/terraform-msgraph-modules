# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/deviceShellScripts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignments", "blockExecutionNotifications", "description", "deviceRunStates", "displayName", "executionFrequency", "fileName", "groupAssignments", "retryCount", "roleScopeTagIds", "runAsAccount", "runSummary", "scriptContent", "userRunStates"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description                   = "example"
    block_execution_notifications = false
    retry_count                   = -2147483648
    assignments                   = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["blockExecutionNotifications"]) == jsonencode(false)
    error_message = "blockExecutionNotifications must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["retryCount"]) == jsonencode(-2147483648)
    error_message = "retryCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagementScriptAssignment" }])
    error_message = "assignments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    run_as_account = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.run_as_account]
}
