# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    share_point_restore_session_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "solutions/backupRestore/sharePointRestoreSessions/test-parent-id/granularSiteRestoreArtifacts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["browseSessionId", "completionDateTime", "restorePointDateTime", "restoredItemKey", "restoredItemPath", "restoredItemWebUrl", "siteId", "startDateTime", "status", "webUrl"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    share_point_restore_session_id = "test-parent-id"
    browse_session_id              = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["browseSessionId"]) == jsonencode("example")
    error_message = "browseSessionId must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    share_point_restore_session_id = "test-parent-id"
    status                         = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
