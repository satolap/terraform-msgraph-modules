# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    service_principal_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "servicePrincipals/test-parent-id/endpoints"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["capability", "deletedDateTime", "providerId", "providerName", "providerResourceId", "uri"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    service_principal_id = "test-parent-id"
    capability           = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["capability"]) == jsonencode("example")
    error_message = "capability must preserve typed values and omit nested nulls."
  }
}
