# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "me/settings/windows"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["instances", "payloadType", "settingType", "windowsDeviceId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    payload_type = "example"
    instances    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["payloadType"]) == jsonencode("example")
    error_message = "payloadType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["instances"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.windowsSettingInstance" }])
    error_message = "instances must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    setting_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.setting_type]
}
