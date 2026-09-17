# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_activity_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "me/activities/test-parent-id/historyItems"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activeDurationSeconds", "activity", "createdDateTime", "expirationDateTime", "lastActiveDateTime", "lastModifiedDateTime", "startedDateTime", "status", "userTimezone"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_activity_id        = "test-parent-id"
    created_date_time       = "2026-01-01T00:00:00Z"
    active_duration_seconds = -2147483648
    activity                = { "activationUrl" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activeDurationSeconds"]) == jsonencode(-2147483648)
    error_message = "activeDurationSeconds must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activity"]) == jsonencode({ "@odata.type" = "#microsoft.graph.userActivity" })
    error_message = "activity must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_activity_id = "test-parent-id"
    status           = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
