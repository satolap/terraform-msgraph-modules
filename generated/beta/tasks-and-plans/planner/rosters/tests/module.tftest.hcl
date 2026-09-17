# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "planner/rosters"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignedSensitivityLabel", "members", "plans"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    members = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["members"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.plannerRosterMember" }])
    error_message = "members must preserve typed values and omit nested nulls."
  }
}
