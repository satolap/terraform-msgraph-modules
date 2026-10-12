# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    planner_roster_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "planner/rosters/test-parent-id/members"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["roles", "tenantId", "userId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    planner_roster_id = "test-parent-id"
    tenant_id         = "example"
    roles             = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["tenantId"]) == jsonencode("example")
    error_message = "tenantId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["roles"]) == jsonencode(["example"])
    error_message = "roles must preserve typed values and omit nested nulls."
  }
}
