# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/vppTokens"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["appleDeviceAppDeliveryProtocolType", "appleId", "automaticallyUpdateApps", "claimTokenManagementFromExternalMdm", "countryOrRegion", "dataSharingConsentGranted", "displayName", "expirationDateTime", "lastModifiedDateTime", "lastSyncDateTime", "lastSyncStatus", "locationName", "organizationName", "roleScopeTagIds", "state", "token", "tokenActionResults", "vppTokenAccountType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    apple_device_app_delivery_protocol_type = "default"
    automatically_update_apps               = false
    role_scope_tag_ids                      = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appleDeviceAppDeliveryProtocolType"]) == jsonencode("default")
    error_message = "appleDeviceAppDeliveryProtocolType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["automaticallyUpdateApps"]) == jsonencode(false)
    error_message = "automaticallyUpdateApps must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["roleScopeTagIds"]) == jsonencode(["example"])
    error_message = "roleScopeTagIds must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    apple_device_app_delivery_protocol_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.apple_device_app_delivery_protocol_type]
}
