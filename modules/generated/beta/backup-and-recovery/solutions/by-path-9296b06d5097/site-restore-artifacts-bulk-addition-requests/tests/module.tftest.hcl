# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    share_point_restore_session_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "solutions/backupRestore/sharePointRestoreSessions/test-parent-id/siteRestoreArtifactsBulkAdditionRequests"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["createdBy", "createdDateTime", "destinationType", "displayName", "error", "lastModifiedBy", "lastModifiedDateTime", "protectionTimePeriod", "protectionUnitIds", "restorePointPreference", "siteIds", "siteWebUrls", "status", "tags"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    share_point_restore_session_id = "test-parent-id"
    created_date_time              = "2026-01-01T00:00:00Z"
    protection_unit_ids            = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["protectionUnitIds"]) == jsonencode(["example"])
    error_message = "protectionUnitIds must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    share_point_restore_session_id = "test-parent-id"
    destination_type               = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.destination_type]
}
