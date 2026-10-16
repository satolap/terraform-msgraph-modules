# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    ios_managed_app_protection_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/iosManagedAppProtections/test-parent-id/apps"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["version", "mobileAppIdentifier"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    ios_managed_app_protection_id = "test-parent-id"
    graph_version                 = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["version"]) == jsonencode("example")
    error_message = "version must preserve typed values and omit nested nulls."
  }
}
