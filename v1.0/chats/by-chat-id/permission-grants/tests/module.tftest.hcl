# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    chat_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "chats/test-parent-id/permissionGrants"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deletedDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    chat_id           = "test-parent-id"
    deleted_date_time = "2026-01-01T00:00:00Z"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deletedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "deletedDateTime must preserve typed values and omit nested nulls."
  }
}
