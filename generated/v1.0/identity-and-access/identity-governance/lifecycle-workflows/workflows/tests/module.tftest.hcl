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
    condition     = jsonencode(msgraph_resource.this.body["administrationScopeTargets"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.directoryObject" }])
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
