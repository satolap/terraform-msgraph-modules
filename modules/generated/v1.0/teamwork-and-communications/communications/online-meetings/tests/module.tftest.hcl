# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "communications/onlineMeetings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowAttendeeToEnableCamera", "allowAttendeeToEnableMic", "allowBreakoutRooms", "allowCopyingAndSharingMeetingContent", "allowLiveShare", "allowMeetingChat", "allowParticipantsToChangeName", "allowPowerPointSharing", "allowRecording", "allowTeamworkReactions", "allowTranscription", "allowWhiteboard", "allowedLobbyAdmitters", "allowedPresenters", "broadcastSettings", "chatInfo", "chatRestrictions", "endDateTime", "expiryDateTime", "externalId", "isBroadcast", "isEndToEndEncryptionEnabled", "isEntryExitAnnounced", "joinMeetingIdSettings", "lobbyBypassSettings", "meetingOptionsWebUrl", "meetingSpokenLanguageTag", "meetingTemplateId", "participants", "recordAutomatically", "sensitivityLabelAssignment", "shareMeetingChatHistoryDefault", "startDateTime", "subject", "watermarkProtection"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    allow_live_share                = "enabled"
    allow_attendee_to_enable_camera = false
    broadcast_settings              = { "allowedAudience" = null }
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
    allow_live_share = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allow_live_share]
}
