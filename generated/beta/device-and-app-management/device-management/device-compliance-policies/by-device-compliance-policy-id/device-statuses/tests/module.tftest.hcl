# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    device_compliance_policy_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/deviceCompliancePolicies/test-parent-id/deviceStatuses"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["complianceGracePeriodExpirationDateTime", "deviceDisplayName", "deviceModel", "lastReportedDateTime", "platform", "status", "userName", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    device_compliance_policy_id                  = "test-parent-id"
    compliance_grace_period_expiration_date_time = "2026-01-01T00:00:00Z"
    platform                                     = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["complianceGracePeriodExpirationDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "complianceGracePeriodExpirationDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["platform"]) == jsonencode(-2147483648)
    error_message = "platform must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    device_compliance_policy_id = "test-parent-id"
    status                      = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
