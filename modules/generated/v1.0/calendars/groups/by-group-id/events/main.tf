# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowNewTimeProposals"      = var.allow_new_time_proposals
    "attendees"                  = (var.attendees == null ? null : [for item0 in var.attendees : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "emailAddress" = item0["emailAddress"], "proposedNewTime" = item0["proposedNewTime"], "status" = item0["status"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "body"                       = var.body
    "bodyPreview"                = var.body_preview
    "cancelledOccurrences"       = (var.cancelled_occurrences == null ? null : [for item0 in var.cancelled_occurrences : item0 if item0 != null])
    "categories"                 = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "createdDateTime"            = var.created_date_time
    "end"                        = var.end
    "exceptionOccurrences"       = (var.exception_occurrences == null ? null : [for item0 in var.exception_occurrences : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowNewTimeProposals" = item0["allowNewTimeProposals"], "attendees" = (item0["attendees"] == null ? null : [for item2 in item0["attendees"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "emailAddress" = item2["emailAddress"], "proposedNewTime" = item2["proposedNewTime"], "status" = item2["status"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]), "body" = item0["body"], "bodyPreview" = item0["bodyPreview"], "cancelledOccurrences" = (item0["cancelledOccurrences"] == null ? null : [for item2 in item0["cancelledOccurrences"] : item2 if item2 != null]), "categories" = (item0["categories"] == null ? null : [for item2 in item0["categories"] : item2 if item2 != null]), "createdDateTime" = item0["createdDateTime"], "end" = item0["end"], "exceptionOccurrences" = (item0["exceptionOccurrences"] == null ? null : [for item2 in item0["exceptionOccurrences"] : item2 if item2 != null]), "extensions" = (item0["extensions"] == null ? null : [for item2 in item0["extensions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"] } : key3 => value3 if value3 != null }) if item2 != null]), "hasAttachments" = item0["hasAttachments"], "hideAttendees" = item0["hideAttendees"], "importance" = item0["importance"], "isAllDay" = item0["isAllDay"], "isCancelled" = item0["isCancelled"], "isDraft" = item0["isDraft"], "isOnlineMeeting" = item0["isOnlineMeeting"], "isOrganizer" = item0["isOrganizer"], "isReminderOn" = item0["isReminderOn"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "location" = item0["location"], "locations" = (item0["locations"] == null ? null : [for item2 in item0["locations"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "address" = item2["address"], "coordinates" = item2["coordinates"], "displayName" = item2["displayName"], "locationEmailAddress" = item2["locationEmailAddress"], "locationUri" = item2["locationUri"], "uniqueId" = item2["uniqueId"], "uniqueIdType" = item2["uniqueIdType"] } : key3 => value3 if value3 != null }) if item2 != null]), "onlineMeetingProvider" = item0["onlineMeetingProvider"], "organizer" = item0["organizer"], "originalEndTimeZone" = item0["originalEndTimeZone"], "originalStart" = item0["originalStart"], "originalStartTimeZone" = item0["originalStartTimeZone"], "recurrence" = item0["recurrence"], "reminderMinutesBeforeStart" = item0["reminderMinutesBeforeStart"], "responseRequested" = item0["responseRequested"], "responseStatus" = item0["responseStatus"], "sensitivity" = item0["sensitivity"], "seriesMasterId" = item0["seriesMasterId"], "showAs" = item0["showAs"], "start" = item0["start"], "subject" = item0["subject"], "transactionId" = item0["transactionId"], "webLink" = item0["webLink"] } : key1 => value1 if value1 != null }) if item0 != null])
    "extensions"                 = (var.extensions == null ? null : [for item0 in var.extensions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "hasAttachments"             = var.has_attachments
    "hideAttendees"              = var.hide_attendees
    "importance"                 = var.importance
    "isAllDay"                   = var.is_all_day
    "isCancelled"                = var.is_cancelled
    "isDraft"                    = var.is_draft
    "isOnlineMeeting"            = var.is_online_meeting
    "isOrganizer"                = var.is_organizer
    "isReminderOn"               = var.is_reminder_on
    "lastModifiedDateTime"       = var.last_modified_date_time
    "location"                   = var.location
    "locations"                  = (var.locations == null ? null : [for item0 in var.locations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "address" = item0["address"], "coordinates" = item0["coordinates"], "displayName" = item0["displayName"], "locationEmailAddress" = item0["locationEmailAddress"], "locationUri" = item0["locationUri"], "uniqueId" = item0["uniqueId"], "uniqueIdType" = item0["uniqueIdType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                = var.odata_type
    "onlineMeetingProvider"      = var.online_meeting_provider
    "organizer"                  = var.organizer
    "originalEndTimeZone"        = var.original_end_time_zone
    "originalStart"              = var.original_start
    "originalStartTimeZone"      = var.original_start_time_zone
    "recurrence"                 = var.recurrence
    "reminderMinutesBeforeStart" = var.reminder_minutes_before_start
    "responseRequested"          = var.response_requested
    "responseStatus"             = var.response_status
    "sensitivity"                = var.sensitivity
    "seriesMasterId"             = var.series_master_id
    "showAs"                     = var.show_as
    "start"                      = var.start
    "subject"                    = var.subject
    "transactionId"              = var.transaction_id
    "webLink"                    = var.web_link
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "groups/${urlencode(var.group_id)}/events"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
