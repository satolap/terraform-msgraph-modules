# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/cases/ediscoveryCases/test-parent-id/reviewSets"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "displayName", "queries"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
    description        = "example"
    queries            = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["queries"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.security.ediscoveryReviewSetQuery" }])
    error_message = "queries must preserve typed values and omit nested nulls."
  }
}
