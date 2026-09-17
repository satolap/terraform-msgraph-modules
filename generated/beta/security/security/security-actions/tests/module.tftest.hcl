# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/securityActions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["actionReason", "appId", "azureTenantId", "clientContext", "completedDateTime", "createdDateTime", "errorInfo", "lastActionDateTime", "name", "parameters", "states", "status", "user", "vendorInformation"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    action_reason = "example"
    parameters    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["actionReason"]) == jsonencode("example")
    error_message = "actionReason must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["parameters"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.keyValuePair" }])
    error_message = "parameters must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
