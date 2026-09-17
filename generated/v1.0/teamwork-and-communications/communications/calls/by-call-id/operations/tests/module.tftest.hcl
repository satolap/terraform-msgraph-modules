# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    call_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "communications/calls/test-parent-id/operations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["clientContext", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    call_id        = "test-parent-id"
    client_context = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["clientContext"]) == jsonencode("example")
    error_message = "clientContext must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    call_id = "test-parent-id"
    status  = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
