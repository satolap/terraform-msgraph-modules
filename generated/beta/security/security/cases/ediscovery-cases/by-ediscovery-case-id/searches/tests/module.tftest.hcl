# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/cases/ediscoveryCases/test-parent-id/searches"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["addToReviewSetOperation", "additionalSources", "contentQuery", "createdBy", "createdDateTime", "custodianSources", "dataSourceScopes", "description", "displayName", "lastEstimateStatisticsOperation", "lastModifiedBy", "lastModifiedDateTime", "noncustodialSources"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
    content_query      = "example"
    additional_sources = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["contentQuery"]) == jsonencode("example")
    error_message = "contentQuery must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["additionalSources"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.security.dataSource" }])
    error_message = "additionalSources must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
    data_source_scopes = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.data_source_scopes]
}
