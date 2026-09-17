# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowAttendeeToEnableCamera"          = var.allow_attendee_to_enable_camera
    "allowAttendeeToEnableMic"             = var.allow_attendee_to_enable_mic
    "allowBreakoutRooms"                   = var.allow_breakout_rooms
    "allowCopyingAndSharingMeetingContent" = var.allow_copying_and_sharing_meeting_content
    "allowLiveShare"                       = var.allow_live_share
    "allowMeetingChat"                     = var.allow_meeting_chat
    "allowParticipantsToChangeName"        = var.allow_participants_to_change_name
    "allowPowerPointSharing"               = var.allow_power_point_sharing
    "allowRecording"                       = var.allow_recording
    "allowTeamworkReactions"               = var.allow_teamwork_reactions
    "allowTranscription"                   = var.allow_transcription
    "allowWhiteboard"                      = var.allow_whiteboard
    "allowedLobbyAdmitters"                = var.allowed_lobby_admitters
    "allowedPresenters"                    = var.allowed_presenters
    "anonymizeIdentityForRoles"            = (var.anonymize_identity_for_roles == null ? null : [for item0 in var.anonymize_identity_for_roles : item0 if item0 != null])
    "capacity"                             = var.capacity
    "chatInfo"                             = var.chat_info
    "chatRestrictions"                     = var.chat_restrictions
    "endDateTime"                          = var.end_date_time
    "expiryDateTime"                       = var.expiry_date_time
    "isEndToEndEncryptionEnabled"          = var.is_end_to_end_encryption_enabled
    "isEntryExitAnnounced"                 = var.is_entry_exit_announced
    "joinMeetingIdSettings"                = var.join_meeting_id_settings
    "lobbyBypassSettings"                  = var.lobby_bypass_settings
    "meetingOptionsWebUrl"                 = var.meeting_options_web_url
    "meetingSpokenLanguageTag"             = var.meeting_spoken_language_tag
    "@odata.type"                          = var.odata_type
    "presenters"                           = (var.presenters == null ? null : [for item0 in var.presenters : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "email" = item0["email"], "identity" = item0["identity"], "presenterDetails" = item0["presenterDetails"], "sessions" = (item0["sessions"] == null ? null : [for item2 in item0["sessions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "allowAttendeeToEnableCamera" = item2["allowAttendeeToEnableCamera"], "allowAttendeeToEnableMic" = item2["allowAttendeeToEnableMic"], "allowBreakoutRooms" = item2["allowBreakoutRooms"], "allowCopyingAndSharingMeetingContent" = item2["allowCopyingAndSharingMeetingContent"], "allowLiveShare" = item2["allowLiveShare"], "allowMeetingChat" = item2["allowMeetingChat"], "allowParticipantsToChangeName" = item2["allowParticipantsToChangeName"], "allowPowerPointSharing" = item2["allowPowerPointSharing"], "allowRecording" = item2["allowRecording"], "allowTeamworkReactions" = item2["allowTeamworkReactions"], "allowTranscription" = item2["allowTranscription"], "allowWhiteboard" = item2["allowWhiteboard"], "allowedLobbyAdmitters" = item2["allowedLobbyAdmitters"], "allowedPresenters" = item2["allowedPresenters"], "anonymizeIdentityForRoles" = (item2["anonymizeIdentityForRoles"] == null ? null : [for item4 in item2["anonymizeIdentityForRoles"] : item4 if item4 != null]), "capacity" = item2["capacity"], "chatInfo" = item2["chatInfo"], "chatRestrictions" = item2["chatRestrictions"], "endDateTime" = item2["endDateTime"], "expiryDateTime" = item2["expiryDateTime"], "isEndToEndEncryptionEnabled" = item2["isEndToEndEncryptionEnabled"], "isEntryExitAnnounced" = item2["isEntryExitAnnounced"], "joinMeetingIdSettings" = item2["joinMeetingIdSettings"], "lobbyBypassSettings" = item2["lobbyBypassSettings"], "meetingOptionsWebUrl" = item2["meetingOptionsWebUrl"], "meetingSpokenLanguageTag" = item2["meetingSpokenLanguageTag"], "presenters" = (item2["presenters"] == null ? null : [for item4 in item2["presenters"] : item4 if item4 != null]), "recordAutomatically" = item2["recordAutomatically"], "registrations" = (item2["registrations"] == null ? null : [for item4 in item2["registrations"] : item4 if item4 != null]), "sensitivityLabelAssignment" = item2["sensitivityLabelAssignment"], "shareMeetingChatHistoryDefault" = item2["shareMeetingChatHistoryDefault"], "startDateTime" = item2["startDateTime"], "subject" = item2["subject"], "videoOnDemandWebUrl" = item2["videoOnDemandWebUrl"], "watermarkProtection" = item2["watermarkProtection"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "recordAutomatically"                  = var.record_automatically
    "registrations"                        = (var.registrations == null ? null : [for item0 in var.registrations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "cancelationDateTime" = item0["cancelationDateTime"], "email" = item0["email"], "externalRegistrationInformation" = item0["externalRegistrationInformation"], "firstName" = item0["firstName"], "lastName" = item0["lastName"], "preferredLanguage" = item0["preferredLanguage"], "preferredTimezone" = item0["preferredTimezone"], "registrantVideoOnDemandWebUrl" = item0["registrantVideoOnDemandWebUrl"], "registrationDateTime" = item0["registrationDateTime"], "registrationQuestionAnswers" = (item0["registrationQuestionAnswers"] == null ? null : [for item2 in item0["registrationQuestionAnswers"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "booleanValue" = item2["booleanValue"], "displayName" = item2["displayName"], "multiChoiceValues" = (item2["multiChoiceValues"] == null ? null : [for item4 in item2["multiChoiceValues"] : item4 if item4 != null]), "questionId" = item2["questionId"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "sessions" = (item0["sessions"] == null ? null : [for item2 in item0["sessions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "allowAttendeeToEnableCamera" = item2["allowAttendeeToEnableCamera"], "allowAttendeeToEnableMic" = item2["allowAttendeeToEnableMic"], "allowBreakoutRooms" = item2["allowBreakoutRooms"], "allowCopyingAndSharingMeetingContent" = item2["allowCopyingAndSharingMeetingContent"], "allowLiveShare" = item2["allowLiveShare"], "allowMeetingChat" = item2["allowMeetingChat"], "allowParticipantsToChangeName" = item2["allowParticipantsToChangeName"], "allowPowerPointSharing" = item2["allowPowerPointSharing"], "allowRecording" = item2["allowRecording"], "allowTeamworkReactions" = item2["allowTeamworkReactions"], "allowTranscription" = item2["allowTranscription"], "allowWhiteboard" = item2["allowWhiteboard"], "allowedLobbyAdmitters" = item2["allowedLobbyAdmitters"], "allowedPresenters" = item2["allowedPresenters"], "anonymizeIdentityForRoles" = (item2["anonymizeIdentityForRoles"] == null ? null : [for item4 in item2["anonymizeIdentityForRoles"] : item4 if item4 != null]), "capacity" = item2["capacity"], "chatInfo" = item2["chatInfo"], "chatRestrictions" = item2["chatRestrictions"], "endDateTime" = item2["endDateTime"], "expiryDateTime" = item2["expiryDateTime"], "isEndToEndEncryptionEnabled" = item2["isEndToEndEncryptionEnabled"], "isEntryExitAnnounced" = item2["isEntryExitAnnounced"], "joinMeetingIdSettings" = item2["joinMeetingIdSettings"], "lobbyBypassSettings" = item2["lobbyBypassSettings"], "meetingOptionsWebUrl" = item2["meetingOptionsWebUrl"], "meetingSpokenLanguageTag" = item2["meetingSpokenLanguageTag"], "presenters" = (item2["presenters"] == null ? null : [for item4 in item2["presenters"] : item4 if item4 != null]), "recordAutomatically" = item2["recordAutomatically"], "registrations" = (item2["registrations"] == null ? null : [for item4 in item2["registrations"] : item4 if item4 != null]), "sensitivityLabelAssignment" = item2["sensitivityLabelAssignment"], "shareMeetingChatHistoryDefault" = item2["shareMeetingChatHistoryDefault"], "startDateTime" = item2["startDateTime"], "subject" = item2["subject"], "videoOnDemandWebUrl" = item2["videoOnDemandWebUrl"], "watermarkProtection" = item2["watermarkProtection"] } : key3 => value3 if value3 != null }) if item2 != null]), "userId" = item0["userId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "sensitivityLabelAssignment"           = var.sensitivity_label_assignment
    "shareMeetingChatHistoryDefault"       = var.share_meeting_chat_history_default
    "startDateTime"                        = var.start_date_time
    "subject"                              = var.subject
    "videoOnDemandWebUrl"                  = var.video_on_demand_web_url
    "watermarkProtection"                  = var.watermark_protection
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/virtualEvents/townhalls/${urlencode(var.virtual_event_townhall_id)}/sessions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
