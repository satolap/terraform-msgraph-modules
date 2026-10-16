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
    "broadcastSettings"                    = (var.broadcast_settings == null ? null : { for key0, value0 in { "@odata.type" = var.broadcast_settings["odata_type"], "allowedAudience" = var.broadcast_settings["allowedAudience"], "captions" = (var.broadcast_settings["captions"] == null ? null : { for key1, value1 in { "@odata.type" = var.broadcast_settings["captions"]["odata_type"], "isCaptionEnabled" = var.broadcast_settings["captions"]["isCaptionEnabled"], "spokenLanguage" = var.broadcast_settings["captions"]["spokenLanguage"], "translationLanguages" = (var.broadcast_settings["captions"]["translationLanguages"] == null ? null : [for item2 in var.broadcast_settings["captions"]["translationLanguages"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }), "isAttendeeReportEnabled" = var.broadcast_settings["isAttendeeReportEnabled"], "isQuestionAndAnswerEnabled" = var.broadcast_settings["isQuestionAndAnswerEnabled"], "isRecordingEnabled" = var.broadcast_settings["isRecordingEnabled"], "isVideoOnDemandEnabled" = var.broadcast_settings["isVideoOnDemandEnabled"] } : key0 => value0 if value0 != null })
    "chatInfo"                             = (var.chat_info == null ? null : { for key0, value0 in { "@odata.type" = var.chat_info["odata_type"], "messageId" = var.chat_info["messageId"], "replyChainMessageId" = var.chat_info["replyChainMessageId"], "threadId" = var.chat_info["threadId"] } : key0 => value0 if value0 != null })
    "chatRestrictions"                     = (var.chat_restrictions == null ? null : { for key0, value0 in { "@odata.type" = var.chat_restrictions["odata_type"], "allowTextOnly" = var.chat_restrictions["allowTextOnly"] } : key0 => value0 if value0 != null })
    "endDateTime"                          = var.end_date_time
    "expiryDateTime"                       = var.expiry_date_time
    "externalId"                           = var.external_id
    "isBroadcast"                          = var.is_broadcast
    "isEndToEndEncryptionEnabled"          = var.is_end_to_end_encryption_enabled
    "isEntryExitAnnounced"                 = var.is_entry_exit_announced
    "joinMeetingIdSettings"                = (var.join_meeting_id_settings == null ? null : { for key0, value0 in { "@odata.type" = var.join_meeting_id_settings["odata_type"], "isPasscodeRequired" = var.join_meeting_id_settings["isPasscodeRequired"] } : key0 => value0 if value0 != null })
    "lobbyBypassSettings"                  = (var.lobby_bypass_settings == null ? null : { for key0, value0 in { "@odata.type" = var.lobby_bypass_settings["odata_type"], "isDialInBypassEnabled" = var.lobby_bypass_settings["isDialInBypassEnabled"], "scope" = var.lobby_bypass_settings["scope"] } : key0 => value0 if value0 != null })
    "meetingOptionsWebUrl"                 = var.meeting_options_web_url
    "meetingSpokenLanguageTag"             = var.meeting_spoken_language_tag
    "meetingTemplateId"                    = var.meeting_template_id
    "@odata.type"                          = var.odata_type
    "participants"                         = (var.participants == null ? null : { for key0, value0 in { "@odata.type" = var.participants["odata_type"], "attendees" = (var.participants["attendees"] == null ? null : [for item1 in var.participants["attendees"] : item1 if item1 != null]), "organizer" = var.participants["organizer"] } : key0 => value0 if value0 != null })
    "recordAutomatically"                  = var.record_automatically
    "sensitivityLabelAssignment"           = (var.sensitivity_label_assignment == null ? null : { for key0, value0 in { "@odata.type" = var.sensitivity_label_assignment["odata_type"], "sensitivityLabelId" = var.sensitivity_label_assignment["sensitivityLabelId"] } : key0 => value0 if value0 != null })
    "shareMeetingChatHistoryDefault"       = var.share_meeting_chat_history_default
    "startDateTime"                        = var.start_date_time
    "subject"                              = var.subject
    "watermarkProtection"                  = (var.watermark_protection == null ? null : { for key0, value0 in { "@odata.type" = var.watermark_protection["odata_type"], "isEnabledForContentSharing" = var.watermark_protection["isEnabledForContentSharing"], "isEnabledForVideo" = var.watermark_protection["isEnabledForVideo"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/onlineMeetings"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
