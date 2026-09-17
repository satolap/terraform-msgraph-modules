# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "cancelationDateTime"             = var.cancelation_date_time
    "email"                           = var.email
    "externalRegistrationInformation" = var.external_registration_information
    "firstName"                       = var.first_name
    "lastName"                        = var.last_name
    "@odata.type"                     = var.odata_type
    "preferredLanguage"               = var.preferred_language
    "preferredTimezone"               = var.preferred_timezone
    "registrationDateTime"            = var.registration_date_time
    "registrationQuestionAnswers"     = (var.registration_question_answers == null ? null : [for item0 in var.registration_question_answers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "booleanValue" = item0["booleanValue"], "displayName" = item0["displayName"], "multiChoiceValues" = (item0["multiChoiceValues"] == null ? null : [for item2 in item0["multiChoiceValues"] : item2 if item2 != null]), "questionId" = item0["questionId"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "sessions"                        = (var.sessions == null ? null : [for item0 in var.sessions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowAttendeeToEnableCamera" = item0["allowAttendeeToEnableCamera"], "allowAttendeeToEnableMic" = item0["allowAttendeeToEnableMic"], "allowBreakoutRooms" = item0["allowBreakoutRooms"], "allowCopyingAndSharingMeetingContent" = item0["allowCopyingAndSharingMeetingContent"], "allowLiveShare" = item0["allowLiveShare"], "allowMeetingChat" = item0["allowMeetingChat"], "allowParticipantsToChangeName" = item0["allowParticipantsToChangeName"], "allowPowerPointSharing" = item0["allowPowerPointSharing"], "allowRecording" = item0["allowRecording"], "allowTeamworkReactions" = item0["allowTeamworkReactions"], "allowTranscription" = item0["allowTranscription"], "allowWhiteboard" = item0["allowWhiteboard"], "allowedLobbyAdmitters" = item0["allowedLobbyAdmitters"], "allowedPresenters" = item0["allowedPresenters"], "capacity" = item0["capacity"], "chatInfo" = item0["chatInfo"], "chatRestrictions" = item0["chatRestrictions"], "endDateTime" = item0["endDateTime"], "expiryDateTime" = item0["expiryDateTime"], "isEndToEndEncryptionEnabled" = item0["isEndToEndEncryptionEnabled"], "isEntryExitAnnounced" = item0["isEntryExitAnnounced"], "joinMeetingIdSettings" = item0["joinMeetingIdSettings"], "lobbyBypassSettings" = item0["lobbyBypassSettings"], "meetingOptionsWebUrl" = item0["meetingOptionsWebUrl"], "meetingSpokenLanguageTag" = item0["meetingSpokenLanguageTag"], "recordAutomatically" = item0["recordAutomatically"], "sensitivityLabelAssignment" = item0["sensitivityLabelAssignment"], "shareMeetingChatHistoryDefault" = item0["shareMeetingChatHistoryDefault"], "startDateTime" = item0["startDateTime"], "subject" = item0["subject"], "videoOnDemandWebUrl" = item0["videoOnDemandWebUrl"], "watermarkProtection" = item0["watermarkProtection"] } : key1 => value1 if value1 != null }) if item0 != null])
    "userId"                          = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/virtualEvents/webinars/${urlencode(var.virtual_event_webinar_id)}/registrations"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
