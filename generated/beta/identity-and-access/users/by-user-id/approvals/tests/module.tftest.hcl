# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/approvals"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["steps"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
    steps   = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["steps"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.approvalStep" }])
    error_message = "steps must preserve typed values and omit nested nulls."
  }
}
