# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/managedDeviceCleanupRules"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["description", "deviceCleanupRulePlatformType", "deviceInactivityBeforeRetirementInDays", "displayName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description                                 = "example"
    device_inactivity_before_retirement_in_days = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceInactivityBeforeRetirementInDays"]) == jsonencode(-2147483648)
    error_message = "deviceInactivityBeforeRetirementInDays must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    device_cleanup_rule_platform_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.device_cleanup_rule_platform_type]
}
