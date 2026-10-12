# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    mac_os_software_update_account_summary_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/macOSSoftwareUpdateAccountSummaries/test-parent-id/categorySummaries"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deviceId", "displayName", "failedUpdateCount", "lastUpdatedDateTime", "successfulUpdateCount", "totalUpdateCount", "updateCategory", "updateStateSummaries", "userId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    mac_os_software_update_account_summary_id = "test-parent-id"
    device_id                                 = "example"
    failed_update_count                       = -2147483648
    update_state_summaries                    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceId"]) == jsonencode("example")
    error_message = "deviceId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["failedUpdateCount"]) == jsonencode(-2147483648)
    error_message = "failedUpdateCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["updateStateSummaries"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.macOSSoftwareUpdateStateSummary" }])
    error_message = "updateStateSummaries must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    mac_os_software_update_account_summary_id = "test-parent-id"
    update_category                           = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.update_category]
}
