# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.onAttributeCollectionListener"
  }

  assert {
    condition     = msgraph_resource.this.url == "identity/authenticationEventListeners"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["authenticationEventsFlowId", "conditions", "displayName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    odata_type                    = "#microsoft.graph.onAttributeCollectionListener"
    authentication_events_flow_id = "example"
    conditions                    = { "applications" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.onAttributeCollectionListener")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["authenticationEventsFlowId"]) == jsonencode("example")
    error_message = "authenticationEventsFlowId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["conditions"]) == jsonencode({ "@odata.type" = "#microsoft.graph.authenticationConditions" })
    error_message = "conditions must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    odata_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
