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

  assert {
    condition     = msgraph_resource.this.ignore_missing_property == true
    error_message = "Default reads must retain the provider missing-property suppression."
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters == null
    error_message = "Default reads must keep the full default GET response."
  }
}

run "selected_response_is_opt_in" {
  command = plan

  variables {
    select_response = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["apps", "assignments", "deploymentSummary"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    allowedInboundDataTransferSourceApps = "none"
    isAssigned                           = false
    deployedAppCount                     = -2147483648
    apps                                 = [{}]
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
    allowedInboundDataTransferSourceApps = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowedInboundDataTransferSourceApps]
}

run "flags_enum_combination" {
  command = plan

  variables {
    allowedInboundDataTransferSourceApps       = "none, OneDriveForBusiness"
    allowedOutboundDataTransferDestinationApps = "none, OneDriveForBusiness"
  }

  assert {
    condition     = msgraph_resource.this.body["allowedInboundDataTransferSourceApps"] == "none, OneDriveForBusiness"
    error_message = "allowedInboundDataTransferSourceApps must accept combined flags enum members."
  }

  assert {
    condition     = msgraph_resource.this.body["allowedOutboundDataTransferDestinationApps"] == "none, OneDriveForBusiness"
    error_message = "allowedOutboundDataTransferDestinationApps must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    allowedInboundDataTransferSourceApps = "none,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowedInboundDataTransferSourceApps]
}

run "timeouts_unset_sends_no_block" {
  command = plan

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    timeouts = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    timeouts = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    timeouts = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    timeouts = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
