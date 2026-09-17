# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    company_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "financials/companies/test-parent-id/paymentMethods"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["code", "displayName", "id", "lastModifiedDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    company_id = "test-parent-id"
    code       = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["code"]) == jsonencode("example")
    error_message = "code must preserve typed values and omit nested nulls."
  }
}
