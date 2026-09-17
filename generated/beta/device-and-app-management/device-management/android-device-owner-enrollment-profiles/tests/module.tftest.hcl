# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/androidDeviceOwnerEnrollmentProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accountId", "configureWifi", "createdDateTime", "description", "deviceNameTemplate", "displayName", "enrolledDeviceCount", "enrollmentMode", "enrollmentTokenType", "enrollmentTokenUsageCount", "isTeamsDeviceProfile", "lastModifiedDateTime", "qrCodeContent", "qrCodeImage", "roleScopeTagIds", "tokenCreationDateTime", "tokenExpirationDateTime", "tokenValue", "wifiHidden", "wifiPassword", "wifiSecurityType", "wifiSsid"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    account_id            = "example"
    configure_wifi        = false
    enrolled_device_count = -2147483648
    role_scope_tag_ids    = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accountId"]) == jsonencode("example")
    error_message = "accountId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["configureWifi"]) == jsonencode(false)
    error_message = "configureWifi must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["enrolledDeviceCount"]) == jsonencode(-2147483648)
    error_message = "enrolledDeviceCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["roleScopeTagIds"]) == jsonencode(["example"])
    error_message = "roleScopeTagIds must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    enrollment_mode = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.enrollment_mode]
}
