# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    group_policy_migration_report_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/groupPolicyMigrationReports/test-parent-id/groupPolicySettingMappings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["admxSettingDefinitionId", "childIdList", "intuneSettingDefinitionId", "intuneSettingUriList", "isMdmSupported", "mdmCspName", "mdmMinimumOSVersion", "mdmSettingUri", "mdmSupportedState", "parentId", "settingCategory", "settingDisplayName", "settingDisplayValue", "settingDisplayValueType", "settingName", "settingScope", "settingType", "settingValue", "settingValueDisplayUnits", "settingValueType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    group_policy_migration_report_id = "test-parent-id"
    admx_setting_definition_id       = "example"
    is_mdm_supported                 = false
    mdm_minimum_os_version           = -2147483648
    child_id_list                    = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["admxSettingDefinitionId"]) == jsonencode("example")
    error_message = "admxSettingDefinitionId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isMdmSupported"]) == jsonencode(false)
    error_message = "isMdmSupported must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["mdmMinimumOSVersion"]) == jsonencode(-2147483648)
    error_message = "mdmMinimumOSVersion must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["childIdList"]) == jsonencode(["example"])
    error_message = "childIdList must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    group_policy_migration_report_id = "test-parent-id"
    mdm_supported_state              = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.mdm_supported_state]
}
