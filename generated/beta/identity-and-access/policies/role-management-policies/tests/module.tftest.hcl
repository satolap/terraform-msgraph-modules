# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "policies/roleManagementPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "displayName", "effectiveRules", "isOrganizationDefault", "lastModifiedBy", "lastModifiedDateTime", "rules", "scopeId", "scopeType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description             = "example"
    is_organization_default = false
    effective_rules         = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isOrganizationDefault"]) == jsonencode(false)
    error_message = "isOrganizationDefault must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["effectiveRules"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.unifiedRoleManagementPolicyRule" }])
    error_message = "effectiveRules must preserve typed values and omit nested nulls."
  }
}
