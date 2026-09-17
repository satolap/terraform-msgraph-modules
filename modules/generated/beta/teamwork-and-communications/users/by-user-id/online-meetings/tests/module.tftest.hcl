# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/onlineMeetings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["allowAttendeeToEnableCamera", "allowAttendeeToEnableMic", "allowBreakoutRooms", "allowCopyingAndSharingMeetingContent", "allowLiveShare", "allowMeetingChat", "allowParticipantsToChangeName", "allowPowerPointSharing", "allowRecording", "allowTeamworkReactions", "allowTranscription", "allowWhiteboard", "allowedLobbyAdmitters", "allowedPresenters", "anonymizeIdentityForRoles", "broadcastRecording", "broadcastSettings", "capabilities", "chatInfo", "chatRestrictions", "endDateTime", "expiryDateTime", "externalId", "isBroadcast", "isEndToEndEncryptionEnabled", "isEntryExitAnnounced", "joinMeetingIdSettings", "joinUrl", "lobbyBypassSettings", "meetingOptionsWebUrl", "meetingSpokenLanguageTag", "meetingTemplateId", "participants", "recordAutomatically", "registration", "sensitivityLabelAssignment", "shareMeetingChatHistoryDefault", "startDateTime", "subject", "watermarkProtection"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id                         = "test-parent-id"
    broadcast_recording             = "example"
    allow_attendee_to_enable_camera = false
    anonymize_identity_for_roles    = ["attendee"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["broadcastRecording"]) == jsonencode("example")
    error_message = "broadcastRecording must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["allowAttendeeToEnableCamera"]) == jsonencode(false)
    error_message = "allowAttendeeToEnableCamera must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["anonymizeIdentityForRoles"]) == jsonencode(["attendee"])
    error_message = "anonymizeIdentityForRoles must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    user_id          = "test-parent-id"
    allow_live_share = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.allow_live_share]
}
