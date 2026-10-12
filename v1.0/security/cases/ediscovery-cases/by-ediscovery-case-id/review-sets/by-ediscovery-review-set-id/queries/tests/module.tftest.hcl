# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    ediscovery_case_id       = "test-parent-id"
    ediscovery_review_set_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/cases/ediscoveryCases/test-parent-id/reviewSets/test-parent-id/queries"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["contentQuery", "createdBy", "createdDateTime", "description", "displayName", "lastModifiedBy", "lastModifiedDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    ediscovery_case_id       = "test-parent-id"
    ediscovery_review_set_id = "test-parent-id"
    content_query            = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["contentQuery"]) == jsonencode("example")
    error_message = "contentQuery must preserve typed values and omit nested nulls."
  }
}
