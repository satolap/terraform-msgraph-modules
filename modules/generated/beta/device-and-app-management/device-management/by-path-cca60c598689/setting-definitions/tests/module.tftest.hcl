# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_management_configuration_policy_template_id  = "test-parent-id"
    device_management_configuration_setting_template_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/configurationPolicyTemplates/test-parent-id/settingTemplates/test-parent-id/settingDefinitions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accessTypes", "applicability", "baseUri", "categoryId", "description", "displayName", "version", "helpText", "infoUrls", "keywords", "name", "occurrence", "offsetUri", "referredSettingInformationList", "riskLevel", "rootDefinitionId", "settingUsage", "uxBehavior", "visibility"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_management_configuration_policy_template_id  = "test-parent-id"
    device_management_configuration_setting_template_id = "test-parent-id"
    access_types                                        = "none"
    occurrence                                          = { "maxDeviceOccurrence" = null }
    info_urls                                           = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accessTypes"]) == jsonencode("none")
    error_message = "accessTypes must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["occurrence"]) == jsonencode({ "@odata.type" = "#microsoft.graph.deviceManagementConfigurationSettingOccurrence" })
    error_message = "occurrence must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["infoUrls"]) == jsonencode(["example"])
    error_message = "infoUrls must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    device_management_configuration_policy_template_id  = "test-parent-id"
    device_management_configuration_setting_template_id = "test-parent-id"
    access_types                                        = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.access_types]
}

run "flags_enum_combination" {
  command = plan

  variables {
    device_management_configuration_policy_template_id  = "test-parent-id"
    device_management_configuration_setting_template_id = "test-parent-id"
    access_types                                        = "none, Add"
    risk_level                                          = "low, Medium"
    setting_usage                                       = "none, Configuration"
    visibility                                          = "none, SettingsCatalog"
  }

  assert {
    condition     = msgraph_resource.this.body["accessTypes"] == "none, Add"
    error_message = "accessTypes must accept combined flags enum members."
  }

  assert {
    condition     = msgraph_resource.this.body["riskLevel"] == "low, Medium"
    error_message = "riskLevel must accept combined flags enum members."
  }

  assert {
    condition     = msgraph_resource.this.body["settingUsage"] == "none, Configuration"
    error_message = "settingUsage must accept combined flags enum members."
  }

  assert {
    condition     = msgraph_resource.this.body["visibility"] == "none, SettingsCatalog"
    error_message = "visibility must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    device_management_configuration_policy_template_id  = "test-parent-id"
    device_management_configuration_setting_template_id = "test-parent-id"
    access_types                                        = "none,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.access_types]
}
