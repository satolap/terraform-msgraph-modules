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
    "broadcastRecording"                   = var.broadcast_recording
    "broadcastSettings"                    = var.broadcast_settings
    "capabilities"                         = (var.capabilities == null ? null : [for item0 in var.capabilities : item0 if item0 != null])
    "chatInfo"                             = var.chat_info
    "chatRestrictions"                     = var.chat_restrictions
    "endDateTime"                          = var.end_date_time
    "expiryDateTime"                       = var.expiry_date_time
    "externalId"                           = var.external_id
    "isBroadcast"                          = var.is_broadcast
    "isEndToEndEncryptionEnabled"          = var.is_end_to_end_encryption_enabled
    "isEntryExitAnnounced"                 = var.is_entry_exit_announced
    "joinMeetingIdSettings"                = var.join_meeting_id_settings
    "joinUrl"                              = var.join_url
    "lobbyBypassSettings"                  = var.lobby_bypass_settings
    "meetingOptionsWebUrl"                 = var.meeting_options_web_url
    "meetingSpokenLanguageTag"             = var.meeting_spoken_language_tag
    "meetingTemplateId"                    = var.meeting_template_id
    "@odata.type"                          = var.odata_type
    "participants"                         = var.participants
    "recordAutomatically"                  = var.record_automatically
    "registration"                         = var.registration
    "sensitivityLabelAssignment"           = var.sensitivity_label_assignment
    "shareMeetingChatHistoryDefault"       = var.share_meeting_chat_history_default
    "startDateTime"                        = var.start_date_time
    "subject"                              = var.subject
    "watermarkProtection"                  = var.watermark_protection
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/onlineMeetings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
