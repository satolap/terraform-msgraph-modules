# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    exchange_restore_session_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "solutions/backupRestore/exchangeRestoreSessions/test-parent-id/mailboxRestoreArtifacts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["completionDateTime", "destinationType", "error", "restorePoint", "restoredFolderId", "restoredItemCount", "startDateTime", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    exchange_restore_session_id = "test-parent-id"
    completion_date_time        = "2026-01-01T00:00:00Z"
    restored_item_count         = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["completionDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "completionDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["restoredItemCount"]) == jsonencode(-2147483648)
    error_message = "restoredItemCount must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    exchange_restore_session_id = "test-parent-id"
    destination_type            = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.destination_type]
}
