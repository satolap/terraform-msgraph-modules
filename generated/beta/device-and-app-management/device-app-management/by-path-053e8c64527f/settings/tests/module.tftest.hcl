# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    targeted_managed_app_configuration_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/targetedManagedAppConfigurations/test-parent-id/settings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["settingInstance"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    targeted_managed_app_configuration_id = "test-parent-id"
    setting_instance                      = { "settingDefinitionId" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["settingInstance"]) == jsonencode({ "@odata.type" = "#microsoft.graph.deviceManagementConfigurationSettingInstance" })
    error_message = "settingInstance must preserve typed values and omit nested nulls."
  }
}
