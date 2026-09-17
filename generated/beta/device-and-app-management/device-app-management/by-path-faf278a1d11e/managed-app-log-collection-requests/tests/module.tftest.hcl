# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    managed_app_registration_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/managedAppRegistrations/test-parent-id/managedAppLogCollectionRequests"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["version", "userLogUploadConsent"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    managed_app_registration_id = "test-parent-id"
    graph_version               = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["version"]) == jsonencode("example")
    error_message = "version must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    managed_app_registration_id = "test-parent-id"
    user_log_upload_consent     = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.user_log_upload_consent]
}
