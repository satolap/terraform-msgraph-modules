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

  assert {
    condition     = msgraph_resource.this.ignore_missing_property == true
    error_message = "Default reads must retain the provider missing-property suppression."
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters == null
    error_message = "Default reads must keep the full default GET response."
  }
}

run "selected_response_is_opt_in" {
  command = plan

  variables {
    group_policy_migration_report_id = "test-parent-id"
    select_response                  = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
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

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    group_policy_migration_report_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    group_policy_migration_report_id = "test-parent-id"
    timeouts                         = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    group_policy_migration_report_id = "test-parent-id"
    timeouts                         = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    group_policy_migration_report_id = "test-parent-id"
    timeouts                         = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    group_policy_migration_report_id = "test-parent-id"
    timeouts                         = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
