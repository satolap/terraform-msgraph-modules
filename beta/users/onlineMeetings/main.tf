# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowAttendeeToEnableCamera"          = var.allowAttendeeToEnableCamera
    "allowAttendeeToEnableMic"             = var.allowAttendeeToEnableMic
    "allowBreakoutRooms"                   = var.allowBreakoutRooms
    "allowCopyingAndSharingMeetingContent" = var.allowCopyingAndSharingMeetingContent
    "allowLiveShare"                       = var.allowLiveShare
    "allowMeetingChat"                     = var.allowMeetingChat
    "allowParticipantsToChangeName"        = var.allowParticipantsToChangeName
    "allowPowerPointSharing"               = var.allowPowerPointSharing
    "allowRecording"                       = var.allowRecording
    "allowTeamworkReactions"               = var.allowTeamworkReactions
    "allowTranscription"                   = var.allowTranscription
    "allowWhiteboard"                      = var.allowWhiteboard
    "allowedLobbyAdmitters"                = var.allowedLobbyAdmitters
    "allowedPresenters"                    = var.allowedPresenters
    "anonymizeIdentityForRoles"            = (var.anonymizeIdentityForRoles == null ? null : [for item0 in var.anonymizeIdentityForRoles : item0 if item0 != null])
    "broadcastRecording"                   = var.broadcastRecording
    "broadcastSettings"                    = (var.broadcastSettings == null ? null : { for key0, value0 in { "@odata.type" = var.broadcastSettings["odata_type"], "allowedAudience" = var.broadcastSettings["allowedAudience"], "captions" = (var.broadcastSettings["captions"] == null ? null : { for key1, value1 in { "@odata.type" = var.broadcastSettings["captions"]["odata_type"], "isCaptionEnabled" = var.broadcastSettings["captions"]["isCaptionEnabled"], "spokenLanguage" = var.broadcastSettings["captions"]["spokenLanguage"], "translationLanguages" = (var.broadcastSettings["captions"]["translationLanguages"] == null ? null : [for item2 in var.broadcastSettings["captions"]["translationLanguages"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }), "isAttendeeReportEnabled" = var.broadcastSettings["isAttendeeReportEnabled"], "isQuestionAndAnswerEnabled" = var.broadcastSettings["isQuestionAndAnswerEnabled"], "isRecordingEnabled" = var.broadcastSettings["isRecordingEnabled"], "isVideoOnDemandEnabled" = var.broadcastSettings["isVideoOnDemandEnabled"] } : key0 => value0 if value0 != null })
    "capabilities"                         = (var.capabilities == null ? null : [for item0 in var.capabilities : item0 if item0 != null])
    "chatInfo"                             = (var.chatInfo == null ? null : { for key0, value0 in { "@odata.type" = var.chatInfo["odata_type"], "messageId" = var.chatInfo["messageId"], "replyChainMessageId" = var.chatInfo["replyChainMessageId"], "threadId" = var.chatInfo["threadId"] } : key0 => value0 if value0 != null })
    "chatRestrictions"                     = (var.chatRestrictions == null ? null : { for key0, value0 in { "@odata.type" = var.chatRestrictions["odata_type"], "allowTextOnly" = var.chatRestrictions["allowTextOnly"] } : key0 => value0 if value0 != null })
    "endDateTime"                          = var.endDateTime
    "expiryDateTime"                       = var.expiryDateTime
    "externalId"                           = var.externalId
    "isBroadcast"                          = var.isBroadcast
    "isEndToEndEncryptionEnabled"          = var.isEndToEndEncryptionEnabled
    "isEntryExitAnnounced"                 = var.isEntryExitAnnounced
    "joinMeetingIdSettings"                = (var.joinMeetingIdSettings == null ? null : { for key0, value0 in { "@odata.type" = var.joinMeetingIdSettings["odata_type"], "isPasscodeRequired" = var.joinMeetingIdSettings["isPasscodeRequired"] } : key0 => value0 if value0 != null })
    "joinUrl"                              = var.joinUrl
    "lobbyBypassSettings"                  = (var.lobbyBypassSettings == null ? null : { for key0, value0 in { "@odata.type" = var.lobbyBypassSettings["odata_type"], "isDialInBypassEnabled" = var.lobbyBypassSettings["isDialInBypassEnabled"], "scope" = var.lobbyBypassSettings["scope"] } : key0 => value0 if value0 != null })
    "meetingOptionsWebUrl"                 = var.meetingOptionsWebUrl
    "meetingSpokenLanguageTag"             = var.meetingSpokenLanguageTag
    "meetingTemplateId"                    = var.meetingTemplateId
    "@odata.type"                          = var.odata_type
    "participants"                         = (var.participants == null ? null : { for key0, value0 in { "@odata.type" = var.participants["odata_type"], "attendees" = (var.participants["attendees"] == null ? null : [for item1 in var.participants["attendees"] : item1 if item1 != null]), "contributors" = (var.participants["contributors"] == null ? null : [for item1 in var.participants["contributors"] : item1 if item1 != null]), "organizer" = var.participants["organizer"], "producers" = (var.participants["producers"] == null ? null : [for item1 in var.participants["producers"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
    "recordAutomatically"                  = var.recordAutomatically
    "registration"                         = var.registration
    "sensitivityLabelAssignment"           = (var.sensitivityLabelAssignment == null ? null : { for key0, value0 in { "@odata.type" = var.sensitivityLabelAssignment["odata_type"], "sensitivityLabelId" = var.sensitivityLabelAssignment["sensitivityLabelId"] } : key0 => value0 if value0 != null })
    "shareMeetingChatHistoryDefault"       = var.shareMeetingChatHistoryDefault
    "startDateTime"                        = var.startDateTime
    "subject"                              = var.subject
    "watermarkProtection"                  = (var.watermarkProtection == null ? null : { for key0, value0 in { "@odata.type" = var.watermarkProtection["odata_type"], "isEnabledForContentSharing" = var.watermarkProtection["isEnabledForContentSharing"], "isEnabledForVideo" = var.watermarkProtection["isEnabledForVideo"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user-id)}/onlineMeetings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["registration"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
