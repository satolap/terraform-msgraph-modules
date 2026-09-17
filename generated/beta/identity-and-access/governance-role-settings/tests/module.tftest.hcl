# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "governanceRoleSettings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["adminEligibleSettings", "adminMemberSettings", "resourceId", "roleDefinitionId", "userEligibleSettings", "userMemberSettings"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    resource_id             = "example"
    admin_eligible_settings = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["resourceId"]) == jsonencode("example")
    error_message = "resourceId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["adminEligibleSettings"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.governanceRuleSetting" }])
    error_message = "adminEligibleSettings must preserve typed values and omit nested nulls."
  }
}
