# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "dataClassification/exactMatchDataStores"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["columns", "dataLastUpdatedDateTime", "description", "displayName", "sessions"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    data_last_updated_date_time = "2026-01-01T00:00:00Z"
    columns                     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["dataLastUpdatedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "dataLastUpdatedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["columns"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.exactDataMatchStoreColumn" }])
    error_message = "columns must preserve typed values and omit nested nulls."
  }
}
