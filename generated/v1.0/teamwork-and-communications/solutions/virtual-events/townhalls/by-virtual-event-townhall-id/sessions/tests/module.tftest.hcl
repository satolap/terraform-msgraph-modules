# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    virtual_event_townhall_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "solutions/virtualEvents/townhalls/test-parent-id/sessions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowAttendeeToEnableCamera", "allowAttendeeToEnableMic", "allowBreakoutRooms", "allowCopyingAndSharingMeetingContent", "allowLiveShare", "allowMeetingChat", "allowParticipantsToChangeName", "allowPowerPointSharing", "allowRecording", "allowTeamworkReactions", "allowTranscription", "allowWhiteboard", "allowedLobbyAdmitters", "allowedPresenters", "capacity", "chatInfo", "chatRestrictions", "endDateTime", "expiryDateTime", "isEndToEndEncryptionEnabled", "isEntryExitAnnounced", "joinMeetingIdSettings", "lobbyBypassSettings", "meetingOptionsWebUrl", "meetingSpokenLanguageTag", "recordAutomatically", "sensitivityLabelAssignment", "shareMeetingChatHistoryDefault", "startDateTime", "subject", "videoOnDemandWebUrl", "watermarkProtection"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    virtual_event_townhall_id       = "test-parent-id"
    expiry_date_time                = "2026-01-01T00:00:00Z"
    allow_attendee_to_enable_camera = false
    capacity                        = -2147483648
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["expiryDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "expiryDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowAttendeeToEnableCamera"]) == jsonencode(false)
    error_message = "allowAttendeeToEnableCamera must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["capacity"]) == jsonencode(-2147483648)
    error_message = "capacity must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    virtual_event_townhall_id = "test-parent-id"
    allow_live_share          = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allow_live_share]
}
