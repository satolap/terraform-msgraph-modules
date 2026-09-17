# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    approval_item_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "solutions/approval/approvalItems/test-parent-id/responses"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["comments", "createdBy", "response"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    approval_item_id = "test-parent-id"
    comments         = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["comments"]) == jsonencode("example")
    error_message = "comments must preserve typed values and omit nested nulls."
  }
}
