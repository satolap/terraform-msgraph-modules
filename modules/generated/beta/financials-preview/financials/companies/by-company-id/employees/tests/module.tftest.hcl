# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    company_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "financials/companies/test-parent-id/employees"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["address", "birthDate", "displayName", "email", "employmentDate", "givenName", "id", "jobTitle", "lastModifiedDateTime", "middleName", "mobilePhone", "number", "personalEmail", "phoneNumber", "picture", "statisticsGroupCode", "status", "surname", "terminationDate"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    company_id = "test-parent-id"
    birth_date = "2026-01-01"
    picture    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["birthDate"]) == jsonencode("2026-01-01")
    error_message = "birthDate must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["picture"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.picture" }])
    error_message = "picture must preserve typed values and omit nested nulls."
  }
}
