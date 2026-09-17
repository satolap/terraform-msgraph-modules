# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/managedTenants/managementTemplateStepTenantSummaries"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignedTenantsCount", "compliantTenantsCount", "createdByUserId", "createdDateTime", "dismissedTenantsCount", "ineligibleTenantsCount", "lastActionByUserId", "lastActionDateTime", "managementTemplateCollectionDisplayName", "managementTemplateCollectionId", "managementTemplateDisplayName", "managementTemplateId", "managementTemplateStepDisplayName", "managementTemplateStepId", "notCompliantTenantsCount"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_by_user_id     = "example"
    assigned_tenants_count = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdByUserId"]) == jsonencode("example")
    error_message = "createdByUserId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignedTenantsCount"]) == jsonencode(-2147483648)
    error_message = "assignedTenantsCount must preserve typed values and omit nested nulls."
  }
}
