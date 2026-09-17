# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    risky_user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityProtection/riskyUsers/test-parent-id/history"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activity", "history", "initiatedBy", "isDeleted", "isProcessing", "riskDetail", "riskLastUpdatedDateTime", "riskLevel", "riskState", "userDisplayName", "userId", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    risky_user_id = "test-parent-id"
    initiated_by  = "example"
    is_deleted    = false
    history       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["initiatedBy"]) == jsonencode("example")
    error_message = "initiatedBy must preserve typed values and omit nested nulls."
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
    risky_user_id = "test-parent-id"
    risk_detail   = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.risk_detail]
}
