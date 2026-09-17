# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    managed_e_book_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/managedEBooks/test-parent-id/assignments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["installIntent", "target"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    managed_e_book_id = "test-parent-id"
    install_intent    = "available"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["installIntent"]) == jsonencode("available")
    error_message = "installIntent must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    managed_e_book_id = "test-parent-id"
    install_intent    = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.install_intent]
}
