# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
    team_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/joinedTeams/test-parent-id/schedule/timeCards"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["breaks", "clockInEvent", "clockOutEvent", "confirmedBy", "createdBy", "notes", "originalEntry", "state", "userId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id   = "test-parent-id"
    team_id   = "test-parent-id"
    user_id_2 = "example"
    breaks    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["userId"]) == jsonencode("example")
    error_message = "userId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["breaks"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.timeCardBreak" }])
    error_message = "breaks must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_id      = "test-parent-id"
    team_id      = "test-parent-id"
    confirmed_by = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.confirmed_by]
}
