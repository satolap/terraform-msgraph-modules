# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "admin/teams/userConfigurations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accountType", "createdDateTime", "effectivePolicyAssignments", "featureTypes", "isEnterpriseVoiceEnabled", "modifiedDateTime", "telephoneNumbers", "tenantId", "user", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    account_type                 = "user"
    is_enterprise_voice_enabled  = false
    effective_policy_assignments = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accountType"]) == jsonencode("user")
    error_message = "accountType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isEnterpriseVoiceEnabled"]) == jsonencode(false)
    error_message = "isEnterpriseVoiceEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["effectivePolicyAssignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.teamsAdministration.effectivePolicyAssignment" }])
    error_message = "effectivePolicyAssignments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    account_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.account_type]
}
