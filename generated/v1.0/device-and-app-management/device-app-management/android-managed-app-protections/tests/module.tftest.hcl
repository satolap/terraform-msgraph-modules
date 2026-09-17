# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/androidManagedAppProtections"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowedDataStorageLocations", "allowedInboundDataTransferSources", "allowedOutboundClipboardSharingLevel", "allowedOutboundDataTransferDestinations", "apps", "assignments", "contactSyncBlocked", "createdDateTime", "customBrowserDisplayName", "customBrowserPackageId", "dataBackupBlocked", "deployedAppCount", "deploymentSummary", "description", "deviceComplianceRequired", "disableAppEncryptionIfDeviceEncryptionIsEnabled", "disableAppPinIfDevicePinIsSet", "displayName", "encryptAppData", "fingerprintBlocked", "version", "isAssigned", "lastModifiedDateTime", "managedBrowser", "managedBrowserToOpenLinksRequired", "maximumPinRetries", "minimumPinLength", "minimumRequiredAppVersion", "minimumRequiredOsVersion", "minimumRequiredPatchVersion", "minimumWarningAppVersion", "minimumWarningOsVersion", "minimumWarningPatchVersion", "organizationalCredentialsRequired", "periodBeforePinReset", "periodOfflineBeforeAccessCheck", "periodOfflineBeforeWipeIsEnforced", "periodOnlineBeforeAccessCheck", "pinCharacterSet", "pinRequired", "printBlocked", "saveAsBlocked", "screenCaptureBlocked", "simplePinBlocked"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    allowed_inbound_data_transfer_sources = "allApps"
    contact_sync_blocked                  = false
    deployed_app_count                    = -2147483648
    allowed_data_storage_locations        = ["oneDriveForBusiness"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedInboundDataTransferSources"]) == jsonencode("allApps")
    error_message = "allowedInboundDataTransferSources must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["contactSyncBlocked"]) == jsonencode(false)
    error_message = "contactSyncBlocked must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deployedAppCount"]) == jsonencode(-2147483648)
    error_message = "deployedAppCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowedDataStorageLocations"]) == jsonencode(["oneDriveForBusiness"])
    error_message = "allowedDataStorageLocations must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    allowed_inbound_data_transfer_sources = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowed_inbound_data_transfer_sources]
}
