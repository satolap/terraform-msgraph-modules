# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "compliance/ediscovery/cases"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["closedBy", "closedDateTime", "createdDateTime", "custodians", "description", "displayName", "externalId", "lastModifiedBy", "lastModifiedDateTime", "legalHolds", "noncustodialDataSources", "operations", "settings", "sourceCollections", "status", "tags"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    closed_date_time = "2026-01-01T00:00:00Z"
    custodians       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["closedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "closedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["custodians"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.ediscovery.custodian" }])
    error_message = "custodians must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
