# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    company_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "financials/companies/test-parent-id/customers"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["address", "blocked", "currency", "currencyCode", "currencyId", "displayName", "email", "id", "lastModifiedDateTime", "number", "paymentMethod", "paymentMethodId", "paymentTerm", "paymentTermsId", "phoneNumber", "picture", "shipmentMethod", "shipmentMethodId", "taxAreaDisplayName", "taxAreaId", "taxLiable", "taxRegistrationNumber", "type", "website"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    company_id = "test-parent-id"
    blocked    = "example"
    tax_liable = false
    picture    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["blocked"]) == jsonencode("example")
    error_message = "blocked must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["taxLiable"]) == jsonencode(false)
    error_message = "taxLiable must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["picture"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.picture" }])
    error_message = "picture must preserve typed values and omit nested nulls."
  }
}
