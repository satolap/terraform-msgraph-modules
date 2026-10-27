# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.activeDirectoryWindowsAutopilotDeploymentProfile"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/windowsAutopilotDeploymentProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignedDevices", "assignments", "description", "deviceNameTemplate", "deviceType", "displayName", "enrollmentStatusScreenSettings", "hardwareHashExtractionEnabled", "locale", "managementServiceAppId", "outOfBoxExperienceSetting", "preprovisioningAllowed", "roleScopeTagIds"] : !contains(keys(msgraph_resource.this.body), key)])
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
    odata_type      = "#microsoft.graph.activeDirectoryWindowsAutopilotDeploymentProfile"
    select_response = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignedDevices", "assignments"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    odata_type                        = "#microsoft.graph.activeDirectoryWindowsAutopilotDeploymentProfile"
    description                       = "example"
    hardware_hash_extraction_enabled  = false
    enrollment_status_screen_settings = { "allowDeviceUseBeforeProfileAndAppInstallComplete" = null }
    assigned_devices                  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.activeDirectoryWindowsAutopilotDeploymentProfile")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hardwareHashExtractionEnabled"]) == jsonencode(false)
    error_message = "hardwareHashExtractionEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["enrollmentStatusScreenSettings"]) == jsonencode({ "@odata.type" = "#microsoft.graph.windowsEnrollmentStatusScreenSettings" })
    error_message = "enrollmentStatusScreenSettings must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignedDevices"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.windowsAutopilotDeviceIdentity" }])
    error_message = "assignedDevices must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    odata_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.activeDirectoryWindowsAutopilotDeploymentProfile"
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.activeDirectoryWindowsAutopilotDeploymentProfile"
    timeouts   = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.activeDirectoryWindowsAutopilotDeploymentProfile"
    timeouts   = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.activeDirectoryWindowsAutopilotDeploymentProfile"
    timeouts   = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.activeDirectoryWindowsAutopilotDeploymentProfile"
    timeouts   = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
