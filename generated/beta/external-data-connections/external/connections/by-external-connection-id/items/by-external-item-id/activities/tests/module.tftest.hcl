# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    external_connection_id = "test-parent-id"
    external_item_id       = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "external/connections/test-parent-id/items/test-parent-id/activities"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["performedBy", "startDateTime", "type"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    external_connection_id = "test-parent-id"
    external_item_id       = "test-parent-id"
    start_date_time        = "2026-01-01T00:00:00Z"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["startDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "startDateTime must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    external_connection_id = "test-parent-id"
    external_item_id       = "test-parent-id"
    type                   = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.type]
}
