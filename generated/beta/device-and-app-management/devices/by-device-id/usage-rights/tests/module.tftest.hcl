# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "devices/test-parent-id/usageRights"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["catalogId", "serviceIdentifier", "state"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_id  = "test-parent-id"
    catalog_id = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["catalogId"]) == jsonencode("example")
    error_message = "catalogId must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    device_id = "test-parent-id"
    state     = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.state]
}
