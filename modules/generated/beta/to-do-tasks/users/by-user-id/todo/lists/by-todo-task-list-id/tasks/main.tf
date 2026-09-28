# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attachmentSessions"            = (var.attachment_sessions == null ? null : [for item0 in var.attachment_sessions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "content" = item0["content"], "expirationDateTime" = item0["expirationDateTime"], "nextExpectedRanges" = (item0["nextExpectedRanges"] == null ? null : [for item2 in item0["nextExpectedRanges"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "attachments"                   = (var.attachments == null ? null : [for item0 in var.attachments : item0 if item0 != null])
    "body"                          = (var.body == null ? null : { for key0, value0 in { "@odata.type" = var.body["odata_type"], "content" = var.body["content"], "contentType" = var.body["contentType"] } : key0 => value0 if value0 != null })
    "bodyLastModifiedDateTime"      = var.body_last_modified_date_time
    "categories"                    = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "checklistItems"                = (var.checklist_items == null ? null : [for item0 in var.checklist_items : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "checkedDateTime" = item0["checkedDateTime"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "isChecked" = item0["isChecked"] } : key1 => value1 if value1 != null }) if item0 != null])
    "completedDateTime"             = (var.completed_date_time == null ? null : { for key0, value0 in { "@odata.type" = var.completed_date_time["odata_type"], "dateTime" = var.completed_date_time["dateTime"], "timeZone" = var.completed_date_time["timeZone"] } : key0 => value0 if value0 != null })
    "createdDateTime"               = var.created_date_time
    "dueDateTime"                   = (var.due_date_time == null ? null : { for key0, value0 in { "@odata.type" = var.due_date_time["odata_type"], "dateTime" = var.due_date_time["dateTime"], "timeZone" = var.due_date_time["timeZone"] } : key0 => value0 if value0 != null })
    "extensions"                    = (var.extensions == null ? null : [for item0 in var.extensions : item0 if item0 != null])
    "hasAttachments"                = var.has_attachments
    "importance"                    = var.importance
    "isReminderOn"                  = var.is_reminder_on
    "lastModifiedDateTime"          = var.last_modified_date_time
    "linkedResources"               = (var.linked_resources == null ? null : [for item0 in var.linked_resources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "applicationName" = item0["applicationName"], "displayName" = item0["displayName"], "externalId" = item0["externalId"], "webUrl" = item0["webUrl"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                   = var.odata_type
    "recurrence"                    = (var.recurrence == null ? null : { for key0, value0 in { "@odata.type" = var.recurrence["odata_type"], "pattern" = (var.recurrence["pattern"] == null ? null : { for key1, value1 in { "@odata.type" = var.recurrence["pattern"]["odata_type"], "dayOfMonth" = var.recurrence["pattern"]["dayOfMonth"], "daysOfWeek" = (var.recurrence["pattern"]["daysOfWeek"] == null ? null : [for item2 in var.recurrence["pattern"]["daysOfWeek"] : item2 if item2 != null]), "firstDayOfWeek" = var.recurrence["pattern"]["firstDayOfWeek"], "index" = var.recurrence["pattern"]["index"], "interval" = var.recurrence["pattern"]["interval"], "month" = var.recurrence["pattern"]["month"], "type" = var.recurrence["pattern"]["type"] } : key1 => value1 if value1 != null }), "range" = (var.recurrence["range"] == null ? null : { for key1, value1 in { "@odata.type" = var.recurrence["range"]["odata_type"], "endDate" = var.recurrence["range"]["endDate"], "numberOfOccurrences" = var.recurrence["range"]["numberOfOccurrences"], "recurrenceTimeZone" = var.recurrence["range"]["recurrenceTimeZone"], "startDate" = var.recurrence["range"]["startDate"], "type" = var.recurrence["range"]["type"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "reminderDateTime"              = (var.reminder_date_time == null ? null : { for key0, value0 in { "@odata.type" = var.reminder_date_time["odata_type"], "dateTime" = var.reminder_date_time["dateTime"], "timeZone" = var.reminder_date_time["timeZone"] } : key0 => value0 if value0 != null })
    "singleValueExtendedProperties" = (var.single_value_extended_properties == null ? null : [for item0 in var.single_value_extended_properties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "startDateTime"                 = (var.start_date_time == null ? null : { for key0, value0 in { "@odata.type" = var.start_date_time["odata_type"], "dateTime" = var.start_date_time["dateTime"], "timeZone" = var.start_date_time["timeZone"] } : key0 => value0 if value0 != null })
    "status"                        = var.status
    "title"                         = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/todo/lists/${urlencode(var.todo_task_list_id)}/tasks"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
