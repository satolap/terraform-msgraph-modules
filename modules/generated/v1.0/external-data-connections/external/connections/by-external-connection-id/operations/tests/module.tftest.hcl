# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    external_connection_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "external/connections/test-parent-id/operations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["error", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    external_connection_id = "test-parent-id"
    status                 = "unspecified"
    error                  = { "code" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["status"]) == jsonencode("unspecified")
    error_message = "status must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["error"]) == jsonencode({ "@odata.type" = "#microsoft.graph.publicError" })
    error_message = "error must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    external_connection_id = "test-parent-id"
    status                 = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
