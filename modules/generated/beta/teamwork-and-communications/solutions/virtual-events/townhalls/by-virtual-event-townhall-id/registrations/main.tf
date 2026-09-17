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
    "registrantVideoOnDemandWebUrl"   = var.registrant_video_on_demand_web_url
    "registrationDateTime"            = var.registration_date_time
    "registrationQuestionAnswers"     = (var.registration_question_answers == null ? null : [for item0 in var.registration_question_answers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "booleanValue" = item0["booleanValue"], "displayName" = item0["displayName"], "multiChoiceValues" = (item0["multiChoiceValues"] == null ? null : [for item2 in item0["multiChoiceValues"] : item2 if item2 != null]), "questionId" = item0["questionId"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "sessions"                        = (var.sessions == null ? null : [for item0 in var.sessions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowAttendeeToEnableCamera" = item0["allowAttendeeToEnableCamera"], "allowAttendeeToEnableMic" = item0["allowAttendeeToEnableMic"], "allowBreakoutRooms" = item0["allowBreakoutRooms"], "allowCopyingAndSharingMeetingContent" = item0["allowCopyingAndSharingMeetingContent"], "allowLiveShare" = item0["allowLiveShare"], "allowMeetingChat" = item0["allowMeetingChat"], "allowParticipantsToChangeName" = item0["allowParticipantsToChangeName"], "allowPowerPointSharing" = item0["allowPowerPointSharing"], "allowRecording" = item0["allowRecording"], "allowTeamworkReactions" = item0["allowTeamworkReactions"], "allowTranscription" = item0["allowTranscription"], "allowWhiteboard" = item0["allowWhiteboard"], "allowedLobbyAdmitters" = item0["allowedLobbyAdmitters"], "allowedPresenters" = item0["allowedPresenters"], "anonymizeIdentityForRoles" = (item0["anonymizeIdentityForRoles"] == null ? null : [for item2 in item0["anonymizeIdentityForRoles"] : item2 if item2 != null]), "capacity" = item0["capacity"], "chatInfo" = item0["chatInfo"], "chatRestrictions" = item0["chatRestrictions"], "endDateTime" = item0["endDateTime"], "expiryDateTime" = item0["expiryDateTime"], "isEndToEndEncryptionEnabled" = item0["isEndToEndEncryptionEnabled"], "isEntryExitAnnounced" = item0["isEntryExitAnnounced"], "joinMeetingIdSettings" = item0["joinMeetingIdSettings"], "lobbyBypassSettings" = item0["lobbyBypassSettings"], "meetingOptionsWebUrl" = item0["meetingOptionsWebUrl"], "meetingSpokenLanguageTag" = item0["meetingSpokenLanguageTag"], "presenters" = (item0["presenters"] == null ? null : [for item2 in item0["presenters"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "email" = item2["email"], "identity" = item2["identity"], "presenterDetails" = item2["presenterDetails"], "sessions" = (item2["sessions"] == null ? null : [for item4 in item2["sessions"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }) if item2 != null]), "recordAutomatically" = item0["recordAutomatically"], "registrations" = (item0["registrations"] == null ? null : [for item2 in item0["registrations"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "cancelationDateTime" = item2["cancelationDateTime"], "email" = item2["email"], "externalRegistrationInformation" = item2["externalRegistrationInformation"], "firstName" = item2["firstName"], "lastName" = item2["lastName"], "preferredLanguage" = item2["preferredLanguage"], "preferredTimezone" = item2["preferredTimezone"], "registrantVideoOnDemandWebUrl" = item2["registrantVideoOnDemandWebUrl"], "registrationDateTime" = item2["registrationDateTime"], "registrationQuestionAnswers" = (item2["registrationQuestionAnswers"] == null ? null : [for item4 in item2["registrationQuestionAnswers"] : item4 if item4 != null]), "sessions" = (item2["sessions"] == null ? null : [for item4 in item2["sessions"] : item4 if item4 != null]), "userId" = item2["userId"] } : key3 => value3 if value3 != null }) if item2 != null]), "sensitivityLabelAssignment" = item0["sensitivityLabelAssignment"], "shareMeetingChatHistoryDefault" = item0["shareMeetingChatHistoryDefault"], "startDateTime" = item0["startDateTime"], "subject" = item0["subject"], "videoOnDemandWebUrl" = item0["videoOnDemandWebUrl"], "watermarkProtection" = item0["watermarkProtection"] } : key1 => value1 if value1 != null }) if item0 != null])
    "userId"                          = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/virtualEvents/townhalls/${urlencode(var.virtual_event_townhall_id)}/registrations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
