# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user-id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/onlineMeetings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowAttendeeToEnableCamera", "allowAttendeeToEnableMic", "allowBreakoutRooms", "allowCopyingAndSharingMeetingContent", "allowLiveShare", "allowMeetingChat", "allowParticipantsToChangeName", "allowPowerPointSharing", "allowRecording", "allowTeamworkReactions", "allowTranscription", "allowWhiteboard", "allowedLobbyAdmitters", "allowedPresenters", "broadcastSettings", "chatInfo", "chatRestrictions", "endDateTime", "expiryDateTime", "externalId", "isBroadcast", "isEndToEndEncryptionEnabled", "isEntryExitAnnounced", "joinMeetingIdSettings", "lobbyBypassSettings", "meetingOptionsWebUrl", "meetingSpokenLanguageTag", "meetingTemplateId", "participants", "recordAutomatically", "sensitivityLabelAssignment", "shareMeetingChatHistoryDefault", "startDateTime", "subject", "watermarkProtection"] : !contains(keys(msgraph_resource.this.body), key)])
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
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    user-id                     = "test-parent-id"
    allowLiveShare              = "enabled"
    allowAttendeeToEnableCamera = false
    broadcastSettings           = { "allowedAudience" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowLiveShare"]) == jsonencode("enabled")
    error_message = "allowLiveShare must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowAttendeeToEnableCamera"]) == jsonencode(false)
    error_message = "allowAttendeeToEnableCamera must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["broadcastSettings"]) == jsonencode({ "@odata.type" = "#microsoft.graph.broadcastMeetingSettings" })
    error_message = "broadcastSettings must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user-id        = "test-parent-id"
    allowLiveShare = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allowLiveShare]
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
