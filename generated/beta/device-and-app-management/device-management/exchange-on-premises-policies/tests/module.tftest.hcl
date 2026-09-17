# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/exchangeOnPremisesPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accessRules", "conditionalAccessSettings", "defaultAccessLevel", "knownDeviceClasses", "notificationContent"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    default_access_level = "none"
    access_rules         = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["defaultAccessLevel"]) == jsonencode("none")
    error_message = "defaultAccessLevel must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accessRules"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagementExchangeAccessRule" }])
    error_message = "accessRules must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    default_access_level = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.default_access_level]
}
