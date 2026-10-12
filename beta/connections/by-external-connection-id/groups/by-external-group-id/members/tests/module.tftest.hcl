# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    external_connection_id = "test-parent-id"
    external_group_id      = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "connections/test-parent-id/groups/test-parent-id/members"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["type"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    external_connection_id = "test-parent-id"
    external_group_id      = "test-parent-id"
    type                   = "user"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["type"]) == jsonencode("user")
    error_message = "type must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    external_connection_id = "test-parent-id"
    external_group_id      = "test-parent-id"
    type                   = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.type]
}
