# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user-id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/calendar/events"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowNewTimeProposals", "attendees", "body", "bodyPreview", "cancelledOccurrences", "categories", "createdDateTime", "end", "exceptionOccurrences", "extensions", "hasAttachments", "hideAttendees", "importance", "isAllDay", "isCancelled", "isDraft", "isOnlineMeeting", "isOrganizer", "isReminderOn", "lastModifiedDateTime", "location", "locations", "onlineMeetingProvider", "organizer", "originalEndTimeZone", "originalStart", "originalStartTimeZone", "recurrence", "reminderMinutesBeforeStart", "responseRequested", "responseStatus", "sensitivity", "seriesMasterId", "showAs", "start", "subject", "transactionId", "webLink"] : !contains(keys(msgraph_resource.this.body), key)])
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
    user-id         = "test-parent-id"
    select_response = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["exceptionOccurrences", "extensions"], name)])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    user-id                    = "test-parent-id"
    bodyPreview                = "example"
    allowNewTimeProposals      = false
    reminderMinutesBeforeStart = -2147483648
    body                       = { "content" = null }
    attendees                  = [{}]
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
    condition     = jsonencode(msgraph_resource.this.body["body"]) == jsonencode({ "@odata.type" = "#microsoft.graph.itemBody" })
    error_message = "body must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["attendees"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.attendee" }])
    error_message = "attendees must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user-id    = "test-parent-id"
    importance = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.importance]
}

run "timeouts_unset_sends_no_block" {
  command = plan

  variables {
    user-id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    user-id  = "test-parent-id"
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
    user-id  = "test-parent-id"
    timeouts = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    user-id  = "test-parent-id"
    timeouts = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    user-id  = "test-parent-id"
    timeouts = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
