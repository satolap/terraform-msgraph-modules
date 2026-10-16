# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id                    = "test-parent-id"
    managed_device_id          = "test-parent-id"
    security_baseline_state_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/managedDevices/test-parent-id/securityBaselineStates/test-parent-id/settingStates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["contributingPolicies", "errorCode", "settingCategoryId", "settingCategoryName", "settingId", "settingName", "sourcePolicies", "state"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id                    = "test-parent-id"
    managed_device_id          = "test-parent-id"
    security_baseline_state_id = "test-parent-id"
    error_code                 = "example"
    contributing_policies      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["errorCode"]) == jsonencode("example")
    error_message = "errorCode must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["contributingPolicies"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.securityBaselineContributingPolicy" }])
    error_message = "contributingPolicies must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_id                    = "test-parent-id"
    managed_device_id          = "test-parent-id"
    security_baseline_state_id = "test-parent-id"
    state                      = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.state]
}
