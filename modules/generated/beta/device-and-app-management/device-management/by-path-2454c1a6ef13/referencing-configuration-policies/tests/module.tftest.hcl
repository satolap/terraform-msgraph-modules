# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_management_reusable_policy_setting_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/reusablePolicySettings/test-parent-id/referencingConfigurationPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignments", "createdDateTime", "creationSource", "description", "disableEntraGroupPolicyAssignment", "lastModifiedDateTime", "name", "platforms", "priorityMetaData", "roleScopeTagIds", "settingCount", "settings", "technologies", "templateReference"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_management_reusable_policy_setting_id = "test-parent-id"
    created_date_time                            = "2026-01-01T00:00:00Z"
    disable_entra_group_policy_assignment        = false
    setting_count                                = -2147483648
    assignments                                  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["disableEntraGroupPolicyAssignment"]) == jsonencode(false)
    error_message = "disableEntraGroupPolicyAssignment must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["settingCount"]) == jsonencode(-2147483648)
    error_message = "settingCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagementConfigurationPolicyAssignment" }])
    error_message = "assignments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    device_management_reusable_policy_setting_id = "test-parent-id"
    platforms                                    = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.platforms]
}
