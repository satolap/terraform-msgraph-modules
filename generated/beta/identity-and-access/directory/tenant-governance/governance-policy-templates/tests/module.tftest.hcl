# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "directory/tenantGovernance/governancePolicyTemplates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdDateTime", "delegatedAdministrationRoleAssignments", "description", "displayName", "governedTenantCanTerminate", "version", "lastModifiedDateTime", "multiTenantApplicationsToProvision"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_date_time                         = "2026-01-01T00:00:00Z"
    governed_tenant_can_terminate             = false
    delegated_administration_role_assignments = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["governedTenantCanTerminate"]) == jsonencode(false)
    error_message = "governedTenantCanTerminate must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["delegatedAdministrationRoleAssignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.delegatedAdministrationRoleAssignment" }])
    error_message = "delegatedAdministrationRoleAssignments must preserve typed values and omit nested nulls."
  }
}
