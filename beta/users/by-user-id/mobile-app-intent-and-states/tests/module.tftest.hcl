# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/mobileAppIntentAndStates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["managedDeviceIdentifier", "mobileAppList", "userId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id                   = "test-parent-id"
    managed_device_identifier = "example"
    mobile_app_list           = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["managedDeviceIdentifier"]) == jsonencode("example")
    error_message = "managedDeviceIdentifier must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["mobileAppList"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.mobileAppIntentAndStateDetail" }])
    error_message = "mobileAppList must preserve typed values and omit nested nulls."
  }
}
