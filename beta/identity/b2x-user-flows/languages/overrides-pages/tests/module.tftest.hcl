# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    b2x_identity_user_flow_id           = "test-parent-id"
    user_flow_language_configuration_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identity/b2xUserFlows/test-parent-id/languages/test-parent-id/overridesPages"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in [] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}
