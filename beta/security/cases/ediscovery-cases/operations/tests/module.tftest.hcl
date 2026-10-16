# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/cases/ediscoveryCases/test-parent-id/operations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["action", "completedDateTime", "createdBy", "createdDateTime", "percentProgress", "resultInfo", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
    action             = "contentExport"
    percent_progress   = -2147483648
    result_info        = { "code" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["action"]) == jsonencode("contentExport")
    error_message = "action must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["percentProgress"]) == jsonencode(-2147483648)
    error_message = "percentProgress must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["resultInfo"]) == jsonencode({ "@odata.type" = "#microsoft.graph.resultInfo" })
    error_message = "resultInfo must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    ediscovery_case_id = "test-parent-id"
    action             = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.action]
}
