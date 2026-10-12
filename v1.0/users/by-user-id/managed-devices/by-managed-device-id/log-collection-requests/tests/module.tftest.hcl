# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id           = "test-parent-id"
    managed_device_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/managedDevices/test-parent-id/logCollectionRequests"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["enrolledByUser", "expirationDateTimeUTC", "initiatedByUserPrincipalName", "managedDeviceId", "receivedDateTimeUTC", "requestedDateTimeUTC", "sizeInKB", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id           = "test-parent-id"
    managed_device_id = "test-parent-id"
    enrolled_by_user  = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["enrolledByUser"]) == jsonencode("example")
    error_message = "enrolledByUser must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_id           = "test-parent-id"
    managed_device_id = "test-parent-id"
    status            = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
