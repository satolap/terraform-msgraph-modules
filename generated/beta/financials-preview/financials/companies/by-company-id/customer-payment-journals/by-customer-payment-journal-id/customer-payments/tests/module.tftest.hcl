# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    company_id                  = "test-parent-id"
    customer_payment_journal_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "financials/companies/test-parent-id/customerPaymentJournals/test-parent-id/customerPayments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["amount", "appliesToInvoiceId", "appliesToInvoiceNumber", "comment", "contactId", "customer", "customerId", "customerNumber", "description", "documentNumber", "externalDocumentNumber", "id", "journalDisplayName", "lastModifiedDateTime", "lineNumber", "postingDate"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    company_id                  = "test-parent-id"
    customer_payment_journal_id = "test-parent-id"
    applies_to_invoice_id       = "00000000-0000-0000-0000-000000000001"
    amount                      = 0
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appliesToInvoiceId"]) == jsonencode("00000000-0000-0000-0000-000000000001")
    error_message = "appliesToInvoiceId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["amount"]) == jsonencode(0)
    error_message = "amount must preserve typed values and omit nested nulls."
  }
}
