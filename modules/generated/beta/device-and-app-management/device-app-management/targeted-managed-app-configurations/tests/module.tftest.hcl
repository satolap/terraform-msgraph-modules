# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/targetedManagedAppConfigurations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appGroupType", "apps", "assignments", "createdDateTime", "customSettings", "deployedAppCount", "deploymentSummary", "description", "displayName", "version", "isAssigned", "lastModifiedDateTime", "roleScopeTagIds", "settings", "targetedAppManagementLevels"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    app_group_type     = "selectedPublicApps"
    is_assigned        = false
    deployed_app_count = -2147483648
    apps               = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appGroupType"]) == jsonencode("selectedPublicApps")
    error_message = "appGroupType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isAssigned"]) == jsonencode(false)
    error_message = "isAssigned must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deployedAppCount"]) == jsonencode(-2147483648)
    error_message = "deployedAppCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["apps"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.managedMobileApp" }])
    error_message = "apps must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    app_group_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.app_group_type]
}

run "flags_enum_combination" {
  command = plan

  variables {
    targeted_app_management_levels = "unspecified, Unmanaged"
  }

  assert {
    condition     = msgraph_resource.this.body["targetedAppManagementLevels"] == "unspecified, Unmanaged"
    error_message = "targetedAppManagementLevels must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    targeted_app_management_levels = "unspecified,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.targeted_app_management_levels]
}
