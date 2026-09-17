# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    policy_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "admin/windows/updates/policies/test-parent-id/rings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deferralInDays", "description", "displayName", "excludedGroupAssignment", "includedGroupAssignment", "isPaused"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    policy_id                 = "test-parent-id"
    description               = "example"
    is_paused                 = false
    deferral_in_days          = -2147483648
    excluded_group_assignment = { "assignments" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isPaused"]) == jsonencode(false)
    error_message = "isPaused must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deferralInDays"]) == jsonencode(-2147483648)
    error_message = "deferralInDays must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["excludedGroupAssignment"]) == jsonencode({ "@odata.type" = "#microsoft.graph.windowsUpdates.excludedGroupAssignment" })
    error_message = "excludedGroupAssignment must preserve typed values and omit nested nulls."
  }
}
