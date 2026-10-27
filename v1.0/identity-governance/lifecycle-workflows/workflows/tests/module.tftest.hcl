# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/lifecycleWorkflows/workflows"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["administrationScopeTargets", "category", "createdBy", "createdDateTime", "deletedDateTime", "description", "displayName", "executionConditions", "executionScope", "version", "id", "isEnabled", "isSchedulingEnabled", "lastModifiedBy", "lastModifiedDateTime", "nextScheduleRunDateTime", "previewScope", "quarantineDetails", "runs", "settings", "subjectProcessingResults", "targetSubjectType", "taskReports", "tasks", "userProcessingResults", "versions"] : !contains(keys(msgraph_resource.this.body), key)])
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
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["administrationScopeTargets", "createdBy", "executionScope", "lastModifiedBy", "previewScope", "runs", "subjectProcessingResults", "taskReports", "tasks", "userProcessingResults", "versions"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    category                     = "joiner"
    is_enabled                   = false
    graph_version                = -2147483648
    quarantine_details           = { "quarantineReason" = null }
    administration_scope_targets = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["category"]) == jsonencode("joiner")
    error_message = "category must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isEnabled"]) == jsonencode(false)
    error_message = "isEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["version"]) == jsonencode(-2147483648)
    error_message = "version must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["quarantineDetails"]) == jsonencode({ "@odata.type" = "#microsoft.graph.identityGovernance.quarantineDetails" })
    error_message = "quarantineDetails must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["administrationScopeTargets"]) == jsonencode([{}])
    error_message = "administrationScopeTargets must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    category = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.category]
}

run "flags_enum_combination" {
  command = plan

  variables {
    target_subject_type = "user, User"
  }

  assert {
    condition     = msgraph_resource.this.body["targetSubjectType"] == "user, User"
    error_message = "targetSubjectType must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    target_subject_type = "user,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.target_subject_type]
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
