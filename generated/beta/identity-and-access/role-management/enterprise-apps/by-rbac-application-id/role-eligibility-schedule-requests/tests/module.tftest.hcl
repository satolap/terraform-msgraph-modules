# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    rbac_application_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "roleManagement/enterpriseApps/test-parent-id/roleEligibilityScheduleRequests"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["action", "appScopeId", "approvalId", "completedDateTime", "createdBy", "createdDateTime", "customData", "directoryScopeId", "isValidationOnly", "justification", "principal", "principalId", "roleDefinition", "roleDefinitionId", "scheduleInfo", "status", "targetSchedule", "targetScheduleId", "ticketInfo"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    rbac_application_id = "test-parent-id"
    action              = "example"
    is_validation_only  = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["action"]) == jsonencode("example")
    error_message = "action must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isValidationOnly"]) == jsonencode(false)
    error_message = "isValidationOnly must preserve typed values and omit nested nulls."
  }
}
