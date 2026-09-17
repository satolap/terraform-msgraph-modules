# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    case_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "compliance/ediscovery/cases/test-parent-id/reviewSets"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayName", "queries"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    case_id      = "test-parent-id"
    display_name = "example"
    queries      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["queries"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.ediscovery.reviewSetQuery" }])
    error_message = "queries must preserve typed values and omit nested nulls."
  }
}
