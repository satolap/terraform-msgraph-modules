# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/configurationPolicyTemplates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowUnmanagedSettings", "baseId", "description", "disableEntraGroupPolicyAssignment", "displayName", "displayVersion", "lifecycleState", "platforms", "settingTemplates", "technologies", "templateFamily"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    base_id                  = "example"
    allow_unmanaged_settings = false
    setting_templates        = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["baseId"]) == jsonencode("example")
    error_message = "baseId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowUnmanagedSettings"]) == jsonencode(false)
    error_message = "allowUnmanagedSettings must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["settingTemplates"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagementConfigurationSettingTemplate" }])
    error_message = "settingTemplates must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    lifecycle_state = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.lifecycle_state]
}

run "flags_enum_combination" {
  command = plan

  variables {
    platforms    = "none, Android"
    technologies = "none, Mdm"
  }

  assert {
    condition     = msgraph_resource.this.body["platforms"] == "none, Android"
    error_message = "platforms must accept combined flags enum members."
  }

  assert {
    condition     = msgraph_resource.this.body["technologies"] == "none, Mdm"
    error_message = "technologies must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    platforms = "none,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.platforms]
}
