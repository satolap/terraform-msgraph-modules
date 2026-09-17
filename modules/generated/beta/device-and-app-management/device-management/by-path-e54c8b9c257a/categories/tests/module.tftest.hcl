# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_management_template_id  = "test-parent-id"
    device_management_template_id1 = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/templates/test-parent-id/migratableTo/test-parent-id/categories"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["displayName", "hasRequiredSetting", "recommendedSettings", "settingDefinitions"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_management_template_id  = "test-parent-id"
    device_management_template_id1 = "test-parent-id"
    display_name                   = "example"
    has_required_setting           = false
    recommended_settings           = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hasRequiredSetting"]) == jsonencode(false)
    error_message = "hasRequiredSetting must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["recommendedSettings"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagementSettingInstance" }])
    error_message = "recommendedSettings must preserve typed values and omit nested nulls."
  }
}
