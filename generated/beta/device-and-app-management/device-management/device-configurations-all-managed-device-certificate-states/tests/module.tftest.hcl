# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/deviceConfigurationsAllManagedDeviceCertificateStates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["certificateExpirationDateTime", "certificateExtendedKeyUsages", "certificateIssuanceDateTime", "certificateIssuerName", "certificateKeyUsages", "certificateRevokeStatus", "certificateRevokeStatusLastChangeDateTime", "certificateSerialNumber", "certificateSubjectName", "certificateThumbprint", "managedDeviceDisplayName", "userPrincipalName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    certificate_expiration_date_time = "2026-01-01T00:00:00Z"
    certificate_key_usages           = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["certificateExpirationDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "certificateExpirationDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["certificateKeyUsages"]) == jsonencode(-2147483648)
    error_message = "certificateKeyUsages must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    certificate_revoke_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.certificate_revoke_status]
}
