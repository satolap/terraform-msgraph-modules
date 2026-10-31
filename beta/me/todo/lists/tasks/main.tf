# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attachmentSessions"            = (var.attachmentSessions == null ? null : [for item0 in var.attachmentSessions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "content" = item0["content"], "expirationDateTime" = item0["expirationDateTime"], "nextExpectedRanges" = (item0["nextExpectedRanges"] == null ? null : [for item2 in item0["nextExpectedRanges"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "attachments"                   = (var.attachments == null ? null : [for item0 in var.attachments : item0 if item0 != null])
    "body"                          = (var.body == null ? null : { for key0, value0 in { "@odata.type" = var.body["odata_type"], "content" = var.body["content"], "contentType" = var.body["contentType"] } : key0 => value0 if value0 != null })
    "bodyLastModifiedDateTime"      = var.bodyLastModifiedDateTime
    "categories"                    = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "checklistItems"                = (var.checklistItems == null ? null : [for item0 in var.checklistItems : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "checkedDateTime" = item0["checkedDateTime"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "isChecked" = item0["isChecked"] } : key1 => value1 if value1 != null }) if item0 != null])
    "completedDateTime"             = (var.completedDateTime == null ? null : { for key0, value0 in { "@odata.type" = var.completedDateTime["odata_type"], "dateTime" = var.completedDateTime["dateTime"], "timeZone" = var.completedDateTime["timeZone"] } : key0 => value0 if value0 != null })
    "createdDateTime"               = var.createdDateTime
    "dueDateTime"                   = (var.dueDateTime == null ? null : { for key0, value0 in { "@odata.type" = var.dueDateTime["odata_type"], "dateTime" = var.dueDateTime["dateTime"], "timeZone" = var.dueDateTime["timeZone"] } : key0 => value0 if value0 != null })
    "extensions"                    = (var.extensions == null ? null : [for item0 in var.extensions : item0 if item0 != null])
    "hasAttachments"                = var.hasAttachments
    "importance"                    = var.importance
    "isReminderOn"                  = var.isReminderOn
    "lastModifiedDateTime"          = var.lastModifiedDateTime
    "linkedResources"               = (var.linkedResources == null ? null : [for item0 in var.linkedResources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "applicationName" = item0["applicationName"], "displayName" = item0["displayName"], "externalId" = item0["externalId"], "webUrl" = item0["webUrl"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                   = var.odata_type
    "recurrence"                    = (var.recurrence == null ? null : { for key0, value0 in { "@odata.type" = var.recurrence["odata_type"], "pattern" = (var.recurrence["pattern"] == null ? null : { for key1, value1 in { "@odata.type" = var.recurrence["pattern"]["odata_type"], "dayOfMonth" = var.recurrence["pattern"]["dayOfMonth"], "daysOfWeek" = (var.recurrence["pattern"]["daysOfWeek"] == null ? null : [for item2 in var.recurrence["pattern"]["daysOfWeek"] : item2 if item2 != null]), "firstDayOfWeek" = var.recurrence["pattern"]["firstDayOfWeek"], "index" = var.recurrence["pattern"]["index"], "interval" = var.recurrence["pattern"]["interval"], "month" = var.recurrence["pattern"]["month"], "type" = var.recurrence["pattern"]["type"] } : key1 => value1 if value1 != null }), "range" = (var.recurrence["range"] == null ? null : { for key1, value1 in { "@odata.type" = var.recurrence["range"]["odata_type"], "endDate" = var.recurrence["range"]["endDate"], "numberOfOccurrences" = var.recurrence["range"]["numberOfOccurrences"], "recurrenceTimeZone" = var.recurrence["range"]["recurrenceTimeZone"], "startDate" = var.recurrence["range"]["startDate"], "type" = var.recurrence["range"]["type"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "reminderDateTime"              = (var.reminderDateTime == null ? null : { for key0, value0 in { "@odata.type" = var.reminderDateTime["odata_type"], "dateTime" = var.reminderDateTime["dateTime"], "timeZone" = var.reminderDateTime["timeZone"] } : key0 => value0 if value0 != null })
    "singleValueExtendedProperties" = (var.singleValueExtendedProperties == null ? null : [for item0 in var.singleValueExtendedProperties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "startDateTime"                 = (var.startDateTime == null ? null : { for key0, value0 in { "@odata.type" = var.startDateTime["odata_type"], "dateTime" = var.startDateTime["dateTime"], "timeZone" = var.startDateTime["timeZone"] } : key0 => value0 if value0 != null })
    "status"                        = var.status
    "title"                         = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "me/todo/lists/${urlencode(var.todoTaskList-id)}/tasks"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["attachmentSessions", "attachments", "checklistItems", "extensions", "linkedResources", "singleValueExtendedProperties"], name)])]))))] } : null

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
