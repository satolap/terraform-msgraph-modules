# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "solutions/backupRestore/exchangeRestoreSessions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["completedDateTime", "createdBy", "createdDateTime", "error", "granularMailboxRestoreArtifacts", "lastModifiedBy", "lastModifiedDateTime", "mailboxRestoreArtifacts", "mailboxRestoreArtifactsBulkAdditionRequests", "restoreJobType", "restoreSessionArtifactCount", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    completed_date_time                = "2026-01-01T00:00:00Z"
    granular_mailbox_restore_artifacts = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["completedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "completedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["granularMailboxRestoreArtifacts"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.granularMailboxRestoreArtifact" }])
    error_message = "granularMailboxRestoreArtifacts must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    restore_job_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.restore_job_type]
}
