# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityProtection/riskyServicePrincipals"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accountEnabled", "appId", "displayName", "history", "isEnabled", "isProcessing", "riskDetail", "riskLastUpdatedDateTime", "riskLevel", "riskState", "servicePrincipalType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    app_id          = "example"
    account_enabled = false
    history         = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appId"]) == jsonencode("example")
    error_message = "appId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accountEnabled"]) == jsonencode(false)
    error_message = "accountEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["history"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.riskyServicePrincipalHistoryItem" }])
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
