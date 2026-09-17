# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "riskyUsers"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["history", "isDeleted", "isProcessing", "riskDetail", "riskLastUpdatedDateTime", "riskLevel", "riskState", "userDisplayName", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    risk_last_updated_date_time = "2026-01-01T00:00:00Z"
    is_deleted                  = false
    history                     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["riskLastUpdatedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "riskLastUpdatedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDeleted"]) == jsonencode(false)
    error_message = "isDeleted must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["history"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.riskyUserHistoryItem" }])
    error_message = "history must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    risk_detail = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.risk_detail]
}
