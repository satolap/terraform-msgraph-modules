# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/privilegedAccess/group/eligibilityScheduleRequests"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accessId", "action", "approvalId", "completedDateTime", "createdBy", "createdDateTime", "customData", "group", "groupId", "isValidationOnly", "justification", "principal", "principalId", "scheduleInfo", "status", "targetSchedule", "targetScheduleId", "ticketInfo"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    approval_id        = "example"
    is_validation_only = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["approvalId"]) == jsonencode("example")
    error_message = "approvalId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isValidationOnly"]) == jsonencode(false)
    error_message = "isValidationOnly must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    access_id = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.access_id]
}
