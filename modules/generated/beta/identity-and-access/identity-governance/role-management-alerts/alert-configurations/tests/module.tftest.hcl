# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/roleManagementAlerts/alertConfigurations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["alertDefinition", "alertDefinitionId", "isEnabled", "scopeId", "scopeType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    alert_definition_id = "example"
    is_enabled          = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alertDefinitionId"]) == jsonencode("example")
    error_message = "alertDefinitionId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isEnabled"]) == jsonencode(false)
    error_message = "isEnabled must preserve typed values and omit nested nulls."
  }
}
