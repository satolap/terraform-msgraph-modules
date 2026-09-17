# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "networkAccess/filteringPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["action", "createdDateTime", "description", "version", "lastModifiedDateTime", "name", "policyRules"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    action       = "block"
    policy_rules = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["action"]) == jsonencode("block")
    error_message = "action must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["policyRules"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.networkaccess.policyRule" }])
    error_message = "policyRules must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    action = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.action]
}
