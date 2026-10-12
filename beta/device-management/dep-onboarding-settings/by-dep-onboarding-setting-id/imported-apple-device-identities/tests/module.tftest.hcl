# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    dep_onboarding_setting_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/depOnboardingSettings/test-parent-id/importedAppleDeviceIdentities"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdDateTime", "description", "discoverySource", "enrollmentState", "isDeleted", "isSupervised", "lastContactedDateTime", "platform", "requestedEnrollmentProfileAssignmentDateTime", "requestedEnrollmentProfileId", "serialNumber"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    dep_onboarding_setting_id = "test-parent-id"
    created_date_time         = "2026-01-01T00:00:00Z"
    is_deleted                = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDeleted"]) == jsonencode(false)
    error_message = "isDeleted must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    dep_onboarding_setting_id = "test-parent-id"
    discovery_source          = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.discovery_source]
}
