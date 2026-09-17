# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    company_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "financials/companies/test-parent-id/currencies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["amountDecimalPlaces", "amountRoundingPrecision", "code", "displayName", "id", "lastModifiedDateTime", "symbol"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    company_id                = "test-parent-id"
    amount_decimal_places     = "example"
    amount_rounding_precision = 0
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["amountDecimalPlaces"]) == jsonencode("example")
    error_message = "amountDecimalPlaces must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["amountRoundingPrecision"]) == jsonencode(0)
    error_message = "amountRoundingPrecision must preserve typed values and omit nested nulls."
  }
}
