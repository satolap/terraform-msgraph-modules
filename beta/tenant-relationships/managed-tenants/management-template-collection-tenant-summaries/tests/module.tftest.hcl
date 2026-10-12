# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/managedTenants/managementTemplateCollectionTenantSummaries"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["completeStepsCount", "completeUsersCount", "createdByUserId", "createdDateTime", "dismissedStepsCount", "excludedUsersCount", "excludedUsersDistinctCount", "incompleteStepsCount", "incompleteUsersCount", "ineligibleStepsCount", "isComplete", "lastActionByUserId", "lastActionDateTime", "managementTemplateCollectionDisplayName", "managementTemplateCollectionId", "regressedStepsCount", "regressedUsersCount", "tenantId", "unlicensedUsersCount"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_by_user_id   = "example"
    is_complete          = false
    complete_steps_count = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdByUserId"]) == jsonencode("example")
    error_message = "createdByUserId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isComplete"]) == jsonencode(false)
    error_message = "isComplete must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["completeStepsCount"]) == jsonencode(-2147483648)
    error_message = "completeStepsCount must preserve typed values and omit nested nulls."
  }
}
