# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityProtection/riskyAgents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["agentDisplayName", "blueprintId", "identityType", "isDeleted", "isEnabled", "isProcessing", "riskDetail", "riskLastModifiedDateTime", "riskLevel", "riskState"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    agent_display_name = "example"
    is_deleted         = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["agentDisplayName"]) == jsonencode("example")
    error_message = "agentDisplayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDeleted"]) == jsonencode(false)
    error_message = "isDeleted must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    identity_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.identity_type]
}
