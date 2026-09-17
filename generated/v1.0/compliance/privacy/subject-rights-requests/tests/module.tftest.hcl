# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "privacy/subjectRightsRequests"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["approvers", "assignedTo", "closedDateTime", "collaborators", "contentQuery", "createdBy", "createdDateTime", "dataSubject", "dataSubjectType", "description", "displayName", "externalId", "history", "includeAllVersions", "includeAuthoredContent", "insight", "internalDueDateTime", "lastModifiedBy", "lastModifiedDateTime", "mailboxLocations", "notes", "pauseAfterEstimate", "regulations", "siteLocations", "stages", "status", "team", "type"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    closed_date_time     = "2026-01-01T00:00:00Z"
    include_all_versions = false
    approvers            = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["closedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "closedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["includeAllVersions"]) == jsonencode(false)
    error_message = "includeAllVersions must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["approvers"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.user" }])
    error_message = "approvers must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    data_subject_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.data_subject_type]
}
