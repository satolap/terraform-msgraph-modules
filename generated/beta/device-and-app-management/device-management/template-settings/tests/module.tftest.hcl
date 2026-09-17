# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/templateSettings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["settingDefinitions", "settingInstanceTemplate"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    setting_instance_template = { "isRequired" = null }
    setting_definitions       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["settingInstanceTemplate"]) == jsonencode({ "@odata.type" = "#microsoft.graph.deviceManagementConfigurationSettingInstanceTemplate" })
    error_message = "settingInstanceTemplate must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["settingDefinitions"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagementConfigurationSettingDefinition" }])
    error_message = "settingDefinitions must preserve typed values and omit nested nulls."
  }
}
