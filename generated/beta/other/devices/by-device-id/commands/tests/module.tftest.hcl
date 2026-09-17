# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "devices/test-parent-id/commands"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appServiceName", "error", "packageFamilyName", "payload", "permissionTicket", "postBackUri", "responsepayload", "status", "type"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_id        = "test-parent-id"
    app_service_name = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appServiceName"]) == jsonencode("example")
    error_message = "appServiceName must preserve typed values and omit nested nulls."
  }
}
