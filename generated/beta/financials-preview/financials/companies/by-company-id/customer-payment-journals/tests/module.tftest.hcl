# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    company_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "financials/companies/test-parent-id/customerPaymentJournals"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["account", "balancingAccountId", "balancingAccountNumber", "code", "customerPayments", "displayName", "id", "lastModifiedDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    company_id           = "test-parent-id"
    balancing_account_id = "00000000-0000-0000-0000-000000000001"
    customer_payments    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["balancingAccountId"]) == jsonencode("00000000-0000-0000-0000-000000000001")
    error_message = "balancingAccountId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["customerPayments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.customerPayment" }])
    error_message = "customerPayments must preserve typed values and omit nested nulls."
  }
}
