# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "me/deviceManagementTroubleshootingEvents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["correlationId", "eventDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    correlation_id = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["correlationId"]) == jsonencode("example")
    error_message = "correlationId must preserve typed values and omit nested nulls."
  }
}
