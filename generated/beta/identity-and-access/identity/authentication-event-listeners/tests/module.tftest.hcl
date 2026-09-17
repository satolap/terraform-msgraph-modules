# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identity/authenticationEventListeners"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["authenticationEventsFlowId", "conditions", "displayName", "priority"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    authentication_events_flow_id = "example"
    priority                      = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["authenticationEventsFlowId"]) == jsonencode("example")
    error_message = "authenticationEventsFlowId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["priority"]) == jsonencode(-2147483648)
    error_message = "priority must preserve typed values and omit nested nulls."
  }
}
