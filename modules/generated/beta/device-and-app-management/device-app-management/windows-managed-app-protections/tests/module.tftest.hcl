# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/windowsManagedAppProtections"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowedInboundDataTransferSourceApps", "allowedInboundDataTransferSources", "allowedOutboundClipboardSharingLevel", "allowedOutboundDataTransferDestinationApps", "allowedOutboundDataTransferDestinations", "appActionIfUnableToAuthenticateUser", "apps", "assignments", "createdDateTime", "deployedAppCount", "deploymentSummary", "description", "displayName", "version", "isAssigned", "lastModifiedDateTime", "maximumAllowedDeviceThreatLevel", "maximumRequiredOsVersion", "maximumWarningOsVersion", "maximumWipeOsVersion", "minimumRequiredAppVersion", "minimumRequiredOsVersion", "minimumRequiredSdkVersion", "minimumWarningAppVersion", "minimumWarningOsVersion", "minimumWipeAppVersion", "minimumWipeOsVersion", "minimumWipeSdkVersion", "mobileThreatDefenseRemediationAction", "periodOfflineBeforeAccessCheck", "periodOfflineBeforeWipeIsEnforced", "printBlocked", "roleScopeTagIds"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    allowed_inbound_data_transfer_source_apps = "none"
    is_assigned                               = false
    deployed_app_count                        = -2147483648
    apps                                      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedInboundDataTransferSourceApps"]) == jsonencode("none")
    error_message = "allowedInboundDataTransferSourceApps must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isAssigned"]) == jsonencode(false)
    error_message = "isAssigned must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deployedAppCount"]) == jsonencode(-2147483648)
    error_message = "deployedAppCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["apps"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.managedMobileApp" }])
    error_message = "apps must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    allowed_inbound_data_transfer_source_apps = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowed_inbound_data_transfer_source_apps]
}
