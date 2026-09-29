# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_management_configuration_policy_template_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/configurationPolicyTemplates/test-parent-id/settingTemplates"
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
    device_management_configuration_policy_template_id = "test-parent-id"
    setting_definitions                                = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["settingDefinitions"]) == jsonencode([{}])
    error_message = "settingDefinitions must preserve typed values and omit nested nulls."
  }
}
