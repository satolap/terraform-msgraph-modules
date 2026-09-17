# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "roleManagement/entitlementManagement/roleAssignmentScheduleRequests"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["action", "activatedUsing", "appScopeId", "approvalId", "completedDateTime", "createdBy", "createdDateTime", "customData", "directoryScopeId", "isValidationOnly", "justification", "principal", "principalId", "roleDefinition", "roleDefinitionId", "scheduleInfo", "status", "targetSchedule", "targetScheduleId", "ticketInfo"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    app_scope_id       = "example"
    is_validation_only = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appScopeId"]) == jsonencode("example")
    error_message = "appScopeId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isValidationOnly"]) == jsonencode(false)
    error_message = "isValidationOnly must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    action = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.action]
}
