# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    team_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "me/joinedTeams/test-parent-id/schedule/openShifts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdBy", "draftOpenShift", "isStagedForDeletion", "schedulingGroupId", "sharedOpenShift"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    team_id                = "test-parent-id"
    scheduling_group_id    = "example"
    is_staged_for_deletion = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["schedulingGroupId"]) == jsonencode("example")
    error_message = "schedulingGroupId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isStagedForDeletion"]) == jsonencode(false)
    error_message = "isStagedForDeletion must preserve typed values and omit nested nulls."
  }
}
