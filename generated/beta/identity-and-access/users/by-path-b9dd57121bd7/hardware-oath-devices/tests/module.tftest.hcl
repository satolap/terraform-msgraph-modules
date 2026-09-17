# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id                                = "test-parent-id"
    hardware_oath_authentication_method_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/authentication/hardwareOathMethods/test-parent-id/device/hardwareOathDevices"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignTo", "assignedTo", "displayName", "hardwareOathDevices", "hashFunction", "manufacturer", "model", "secretKey", "serialNumber", "status", "timeIntervalInSeconds"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id                                = "test-parent-id"
    hardware_oath_authentication_method_id = "test-parent-id"
    display_name                           = "example"
    time_interval_in_seconds               = -2147483648
    hardware_oath_devices                  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["displayName"]) == jsonencode("example")
    error_message = "displayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["timeIntervalInSeconds"]) == jsonencode(-2147483648)
    error_message = "timeIntervalInSeconds must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hardwareOathDevices"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.hardwareOathTokenAuthenticationMethodDevice" }])
    error_message = "hardwareOathDevices must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_id                                = "test-parent-id"
    hardware_oath_authentication_method_id = "test-parent-id"
    hash_function                          = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.hash_function]
}
