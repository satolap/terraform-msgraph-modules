# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/groupPolicyMigrationReports"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdDateTime", "displayName", "groupPolicyCreatedDateTime", "groupPolicyLastModifiedDateTime", "groupPolicyObjectId", "groupPolicySettingMappings", "lastModifiedDateTime", "migrationReadiness", "ouDistinguishedName", "roleScopeTagIds", "supportedSettingsCount", "supportedSettingsPercent", "targetedInActiveDirectory", "totalSettingsCount", "unsupportedGroupPolicyExtensions"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_date_time             = "2026-01-01T00:00:00Z"
    targeted_in_active_directory  = false
    supported_settings_count      = -2147483648
    group_policy_setting_mappings = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["targetedInActiveDirectory"]) == jsonencode(false)
    error_message = "targetedInActiveDirectory must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["supportedSettingsCount"]) == jsonencode(-2147483648)
    error_message = "supportedSettingsCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["groupPolicySettingMappings"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.groupPolicySettingMapping" }])
    error_message = "groupPolicySettingMappings must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    migration_readiness = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.migration_readiness]
}
