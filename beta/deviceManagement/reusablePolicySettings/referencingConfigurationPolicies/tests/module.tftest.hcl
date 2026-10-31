# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    deviceManagementReusablePolicySetting-id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/reusablePolicySettings/test-parent-id/referencingConfigurationPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignments", "createdDateTime", "creationSource", "description", "disableEntraGroupPolicyAssignment", "lastModifiedDateTime", "name", "platforms", "priorityMetaData", "roleScopeTagIds", "settingCount", "settings", "technologies", "templateReference"] : !contains(keys(msgraph_resource.this.body), key)])
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
    deviceManagementReusablePolicySetting-id = "test-parent-id"
    select_response                          = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments", "settings"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    deviceManagementReusablePolicySetting-id = "test-parent-id"
    createdDateTime                          = "2026-01-01T00:00:00Z"
    disableEntraGroupPolicyAssignment        = false
    settingCount                             = -2147483648
    priorityMetaData                         = { "priority" = null }
    assignments                              = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["disableEntraGroupPolicyAssignment"]) == jsonencode(false)
    error_message = "disableEntraGroupPolicyAssignment must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["settingCount"]) == jsonencode(-2147483648)
    error_message = "settingCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["priorityMetaData"]) == jsonencode({ "@odata.type" = "#microsoft.graph.deviceManagementPriorityMetaData" })
    error_message = "priorityMetaData must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.deviceManagementConfigurationPolicyAssignment" }])
    error_message = "assignments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    deviceManagementReusablePolicySetting-id = "test-parent-id"
    platforms                                = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.platforms]
}

run "flags_enum_combination" {
  command = plan

  variables {
    deviceManagementReusablePolicySetting-id = "test-parent-id"
    platforms                                = "none, Android"
    technologies                             = "none, Mdm"
  }

  assert {
    condition     = msgraph_resource.this.body["platforms"] == "none, Android"
    error_message = "platforms must accept combined flags enum members."
  }

  assert {
    condition     = msgraph_resource.this.body["technologies"] == "none, Mdm"
    error_message = "technologies must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    deviceManagementReusablePolicySetting-id = "test-parent-id"
    platforms                                = "none,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.platforms]
}

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    deviceManagementReusablePolicySetting-id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    deviceManagementReusablePolicySetting-id = "test-parent-id"
    timeouts                                 = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    deviceManagementReusablePolicySetting-id = "test-parent-id"
    timeouts                                 = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    deviceManagementReusablePolicySetting-id = "test-parent-id"
    timeouts                                 = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    deviceManagementReusablePolicySetting-id = "test-parent-id"
    timeouts                                 = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
