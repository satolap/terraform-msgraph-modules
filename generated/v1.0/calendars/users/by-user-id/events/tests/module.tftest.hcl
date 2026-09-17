# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/events"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowNewTimeProposals", "attendees", "body", "bodyPreview", "cancelledOccurrences", "categories", "createdDateTime", "end", "exceptionOccurrences", "extensions", "hasAttachments", "hideAttendees", "importance", "isAllDay", "isCancelled", "isDraft", "isOnlineMeeting", "isOrganizer", "isReminderOn", "lastModifiedDateTime", "location", "locations", "onlineMeetingProvider", "organizer", "originalEndTimeZone", "originalStart", "originalStartTimeZone", "recurrence", "reminderMinutesBeforeStart", "responseRequested", "responseStatus", "sensitivity", "seriesMasterId", "showAs", "start", "subject", "transactionId", "webLink"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id                       = "test-parent-id"
    body_preview                  = "example"
    allow_new_time_proposals      = false
    reminder_minutes_before_start = -2147483648
    attendees                     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["bodyPreview"]) == jsonencode("example")
    error_message = "bodyPreview must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowNewTimeProposals"]) == jsonencode(false)
    error_message = "allowNewTimeProposals must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["reminderMinutesBeforeStart"]) == jsonencode(-2147483648)
    error_message = "reminderMinutesBeforeStart must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["attendees"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.attendee" }])
    error_message = "attendees must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_id    = "test-parent-id"
    importance = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.importance]
}
