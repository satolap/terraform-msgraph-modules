# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/privilegedAccess/group/assignmentScheduleInstances"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accessId", "activatedUsing", "assignmentScheduleId", "assignmentType", "endDateTime", "group", "groupId", "memberType", "principal", "principalId", "startDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    assignment_schedule_id = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignmentScheduleId"]) == jsonencode("example")
    error_message = "assignmentScheduleId must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    access_id = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.access_id]
}
