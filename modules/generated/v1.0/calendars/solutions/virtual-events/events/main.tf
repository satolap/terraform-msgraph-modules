# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"                = var.created_by
    "description"              = var.description
    "displayName"              = var.display_name
    "endDateTime"              = var.end_date_time
    "externalEventInformation" = (var.external_event_information == null ? null : [for item0 in var.external_event_information : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "externalEventId" = item0["externalEventId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isRegistrationRequired"   = var.is_registration_required
    "@odata.type"              = var.odata_type
    "presenters"               = (var.presenters == null ? null : [for item0 in var.presenters : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "email" = item0["email"], "identity" = item0["identity"], "presenterDetails" = item0["presenterDetails"] } : key1 => value1 if value1 != null }) if item0 != null])
    "sessions"                 = (var.sessions == null ? null : [for item0 in var.sessions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowAttendeeToEnableCamera" = item0["allowAttendeeToEnableCamera"], "allowAttendeeToEnableMic" = item0["allowAttendeeToEnableMic"], "allowBreakoutRooms" = item0["allowBreakoutRooms"], "allowCopyingAndSharingMeetingContent" = item0["allowCopyingAndSharingMeetingContent"], "allowLiveShare" = item0["allowLiveShare"], "allowMeetingChat" = item0["allowMeetingChat"], "allowParticipantsToChangeName" = item0["allowParticipantsToChangeName"], "allowPowerPointSharing" = item0["allowPowerPointSharing"], "allowRecording" = item0["allowRecording"], "allowTeamworkReactions" = item0["allowTeamworkReactions"], "allowTranscription" = item0["allowTranscription"], "allowWhiteboard" = item0["allowWhiteboard"], "allowedLobbyAdmitters" = item0["allowedLobbyAdmitters"], "allowedPresenters" = item0["allowedPresenters"], "capacity" = item0["capacity"], "chatInfo" = item0["chatInfo"], "chatRestrictions" = item0["chatRestrictions"], "endDateTime" = item0["endDateTime"], "expiryDateTime" = item0["expiryDateTime"], "isEndToEndEncryptionEnabled" = item0["isEndToEndEncryptionEnabled"], "isEntryExitAnnounced" = item0["isEntryExitAnnounced"], "joinMeetingIdSettings" = item0["joinMeetingIdSettings"], "lobbyBypassSettings" = item0["lobbyBypassSettings"], "meetingOptionsWebUrl" = item0["meetingOptionsWebUrl"], "meetingSpokenLanguageTag" = item0["meetingSpokenLanguageTag"], "recordAutomatically" = item0["recordAutomatically"], "sensitivityLabelAssignment" = item0["sensitivityLabelAssignment"], "shareMeetingChatHistoryDefault" = item0["shareMeetingChatHistoryDefault"], "startDateTime" = item0["startDateTime"], "subject" = item0["subject"], "videoOnDemandWebUrl" = item0["videoOnDemandWebUrl"], "watermarkProtection" = item0["watermarkProtection"] } : key1 => value1 if value1 != null }) if item0 != null])
    "settings"                 = var.settings
    "startDateTime"            = var.start_date_time
    "status"                   = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/virtualEvents/events"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
