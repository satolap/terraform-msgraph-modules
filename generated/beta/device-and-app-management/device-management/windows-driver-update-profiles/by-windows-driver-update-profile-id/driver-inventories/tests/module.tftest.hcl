# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    windows_driver_update_profile_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/windowsDriverUpdateProfiles/test-parent-id/driverInventories"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["applicableDeviceCount", "approvalStatus", "category", "deployDateTime", "driverClass", "version", "manufacturer", "name", "releaseDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    windows_driver_update_profile_id = "test-parent-id"
    approval_status                  = "needsReview"
    applicable_device_count          = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["approvalStatus"]) == jsonencode("needsReview")
    error_message = "approvalStatus must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["applicableDeviceCount"]) == jsonencode(-2147483648)
    error_message = "applicableDeviceCount must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    windows_driver_update_profile_id = "test-parent-id"
    approval_status                  = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.approval_status]
}
