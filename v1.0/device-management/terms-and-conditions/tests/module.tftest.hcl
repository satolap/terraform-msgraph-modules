# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/termsAndConditions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["acceptanceStatement", "acceptanceStatuses", "assignments", "bodyText", "createdDateTime", "description", "displayName", "version", "lastModifiedDateTime", "title"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    acceptance_statement = "example"
    graph_version        = -2147483648
    acceptance_statuses  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["acceptanceStatement"]) == jsonencode("example")
    error_message = "acceptanceStatement must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["version"]) == jsonencode(-2147483648)
    error_message = "version must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["acceptanceStatuses"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.termsAndConditionsAcceptanceStatus" }])
    error_message = "acceptanceStatuses must preserve typed values and omit nested nulls."
  }
}
