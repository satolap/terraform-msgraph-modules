# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_management_template_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/templates/test-parent-id/settings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["definitionId", "valueJson"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_management_template_id = "test-parent-id"
    definition_id                 = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["definitionId"]) == jsonencode("example")
    error_message = "definitionId must preserve typed values and omit nested nulls."
  }
}
