# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowNewTimeProposals"      = var.allow_new_time_proposals
    "attendees"                  = (var.attendees == null ? null : [for item0 in var.attendees : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "emailAddress" = item0["emailAddress"], "proposedNewTime" = item0["proposedNewTime"], "status" = (item0["status"] == null ? null : { for key2, value2 in { "@odata.type" = item0["status"]["odata_type"], "response" = item0["status"]["response"], "time" = item0["status"]["time"] } : key2 => value2 if value2 != null }), "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "body"                       = (var.body == null ? null : { for key0, value0 in { "@odata.type" = var.body["odata_type"], "content" = var.body["content"], "contentType" = var.body["contentType"] } : key0 => value0 if value0 != null })
    "bodyPreview"                = var.body_preview
    "cancelledOccurrences"       = (var.cancelled_occurrences == null ? null : [for item0 in var.cancelled_occurrences : item0 if item0 != null])
    "categories"                 = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "createdDateTime"            = var.created_date_time
    "end"                        = (var.end == null ? null : { for key0, value0 in { "@odata.type" = var.end["odata_type"], "dateTime" = var.end["dateTime"], "timeZone" = var.end["timeZone"] } : key0 => value0 if value0 != null })
    "exceptionOccurrences"       = (var.exception_occurrences == null ? null : [for item0 in var.exception_occurrences : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowNewTimeProposals" = item0["allowNewTimeProposals"], "attendees" = (item0["attendees"] == null ? null : [for item2 in item0["attendees"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "emailAddress" = item2["emailAddress"], "proposedNewTime" = item2["proposedNewTime"], "status" = (item2["status"] == null ? null : { for key4, value4 in { "@odata.type" = item2["status"]["odata_type"], "response" = item2["status"]["response"], "time" = item2["status"]["time"] } : key4 => value4 if value4 != null }), "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]), "body" = (item0["body"] == null ? null : { for key2, value2 in { "@odata.type" = item0["body"]["odata_type"], "content" = item0["body"]["content"], "contentType" = item0["body"]["contentType"] } : key2 => value2 if value2 != null }), "bodyPreview" = item0["bodyPreview"], "cancelledOccurrences" = (item0["cancelledOccurrences"] == null ? null : [for item2 in item0["cancelledOccurrences"] : item2 if item2 != null]), "categories" = (item0["categories"] == null ? null : [for item2 in item0["categories"] : item2 if item2 != null]), "createdDateTime" = item0["createdDateTime"], "end" = (item0["end"] == null ? null : { for key2, value2 in { "@odata.type" = item0["end"]["odata_type"], "dateTime" = item0["end"]["dateTime"], "timeZone" = item0["end"]["timeZone"] } : key2 => value2 if value2 != null }), "exceptionOccurrences" = (item0["exceptionOccurrences"] == null ? null : [for item2 in item0["exceptionOccurrences"] : item2 if item2 != null]), "extensions" = (item0["extensions"] == null ? null : [for item2 in item0["extensions"] : item2 if item2 != null]), "hasAttachments" = item0["hasAttachments"], "hideAttendees" = item0["hideAttendees"], "importance" = item0["importance"], "isAllDay" = item0["isAllDay"], "isCancelled" = item0["isCancelled"], "isDraft" = item0["isDraft"], "isOnlineMeeting" = item0["isOnlineMeeting"], "isOrganizer" = item0["isOrganizer"], "isReminderOn" = item0["isReminderOn"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "location" = item0["location"], "locations" = (item0["locations"] == null ? null : [for item2 in item0["locations"] : item2 if item2 != null]), "occurrenceId" = item0["occurrenceId"], "onlineMeetingProvider" = item0["onlineMeetingProvider"], "organizer" = item0["organizer"], "originalEndTimeZone" = item0["originalEndTimeZone"], "originalStart" = item0["originalStart"], "originalStartTimeZone" = item0["originalStartTimeZone"], "recurrence" = (item0["recurrence"] == null ? null : { for key2, value2 in { "@odata.type" = item0["recurrence"]["odata_type"], "pattern" = (item0["recurrence"]["pattern"] == null ? null : { for key3, value3 in { "@odata.type" = item0["recurrence"]["pattern"]["odata_type"], "dayOfMonth" = item0["recurrence"]["pattern"]["dayOfMonth"], "daysOfWeek" = (item0["recurrence"]["pattern"]["daysOfWeek"] == null ? null : [for item4 in item0["recurrence"]["pattern"]["daysOfWeek"] : item4 if item4 != null]), "firstDayOfWeek" = item0["recurrence"]["pattern"]["firstDayOfWeek"], "index" = item0["recurrence"]["pattern"]["index"], "interval" = item0["recurrence"]["pattern"]["interval"], "month" = item0["recurrence"]["pattern"]["month"], "type" = item0["recurrence"]["pattern"]["type"] } : key3 => value3 if value3 != null }), "range" = (item0["recurrence"]["range"] == null ? null : { for key3, value3 in { "@odata.type" = item0["recurrence"]["range"]["odata_type"], "endDate" = item0["recurrence"]["range"]["endDate"], "numberOfOccurrences" = item0["recurrence"]["range"]["numberOfOccurrences"], "recurrenceTimeZone" = item0["recurrence"]["range"]["recurrenceTimeZone"], "startDate" = item0["recurrence"]["range"]["startDate"], "type" = item0["recurrence"]["range"]["type"] } : key3 => value3 if value3 != null }) } : key2 => value2 if value2 != null }), "reminderMinutesBeforeStart" = item0["reminderMinutesBeforeStart"], "responseRequested" = item0["responseRequested"], "responseStatus" = (item0["responseStatus"] == null ? null : { for key2, value2 in { "@odata.type" = item0["responseStatus"]["odata_type"], "response" = item0["responseStatus"]["response"], "time" = item0["responseStatus"]["time"] } : key2 => value2 if value2 != null }), "sensitivity" = item0["sensitivity"], "seriesMasterId" = item0["seriesMasterId"], "showAs" = item0["showAs"], "start" = (item0["start"] == null ? null : { for key2, value2 in { "@odata.type" = item0["start"]["odata_type"], "dateTime" = item0["start"]["dateTime"], "timeZone" = item0["start"]["timeZone"] } : key2 => value2 if value2 != null }), "subject" = item0["subject"], "transactionId" = item0["transactionId"], "uid" = item0["uid"], "webLink" = item0["webLink"] } : key1 => value1 if value1 != null }) if item0 != null])
    "extensions"                 = (var.extensions == null ? null : [for item0 in var.extensions : item0 if item0 != null])
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
    "locations"                  = (var.locations == null ? null : [for item0 in var.locations : item0 if item0 != null])
    "occurrenceId"               = var.occurrence_id
    "@odata.type"                = var.odata_type
    "onlineMeetingProvider"      = var.online_meeting_provider
    "organizer"                  = var.organizer
    "originalEndTimeZone"        = var.original_end_time_zone
    "originalStart"              = var.original_start
    "originalStartTimeZone"      = var.original_start_time_zone
    "recurrence"                 = (var.recurrence == null ? null : { for key0, value0 in { "@odata.type" = var.recurrence["odata_type"], "pattern" = (var.recurrence["pattern"] == null ? null : { for key1, value1 in { "@odata.type" = var.recurrence["pattern"]["odata_type"], "dayOfMonth" = var.recurrence["pattern"]["dayOfMonth"], "daysOfWeek" = (var.recurrence["pattern"]["daysOfWeek"] == null ? null : [for item2 in var.recurrence["pattern"]["daysOfWeek"] : item2 if item2 != null]), "firstDayOfWeek" = var.recurrence["pattern"]["firstDayOfWeek"], "index" = var.recurrence["pattern"]["index"], "interval" = var.recurrence["pattern"]["interval"], "month" = var.recurrence["pattern"]["month"], "type" = var.recurrence["pattern"]["type"] } : key1 => value1 if value1 != null }), "range" = (var.recurrence["range"] == null ? null : { for key1, value1 in { "@odata.type" = var.recurrence["range"]["odata_type"], "endDate" = var.recurrence["range"]["endDate"], "numberOfOccurrences" = var.recurrence["range"]["numberOfOccurrences"], "recurrenceTimeZone" = var.recurrence["range"]["recurrenceTimeZone"], "startDate" = var.recurrence["range"]["startDate"], "type" = var.recurrence["range"]["type"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "reminderMinutesBeforeStart" = var.reminder_minutes_before_start
    "responseRequested"          = var.response_requested
    "responseStatus"             = (var.response_status == null ? null : { for key0, value0 in { "@odata.type" = var.response_status["odata_type"], "response" = var.response_status["response"], "time" = var.response_status["time"] } : key0 => value0 if value0 != null })
    "sensitivity"                = var.sensitivity
    "seriesMasterId"             = var.series_master_id
    "showAs"                     = var.show_as
    "start"                      = (var.start == null ? null : { for key0, value0 in { "@odata.type" = var.start["odata_type"], "dateTime" = var.start["dateTime"], "timeZone" = var.start["timeZone"] } : key0 => value0 if value0 != null })
    "subject"                    = var.subject
    "transactionId"              = var.transaction_id
    "uid"                        = var.uid
    "webLink"                    = var.web_link
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/calendars/${urlencode(var.calendar_id)}/events"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
