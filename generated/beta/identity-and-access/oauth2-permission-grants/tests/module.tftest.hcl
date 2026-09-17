# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "oauth2PermissionGrants"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["clientId", "consentType", "expiryTime", "principalId", "resourceId", "scope", "startTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    client_id = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["clientId"]) == jsonencode("example")
    error_message = "clientId must preserve typed values and omit nested nulls."
  }
}
