# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attachmentSessions"            = (var.attachment_sessions == null ? null : [for item0 in var.attachment_sessions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "content" = item0["content"], "expirationDateTime" = item0["expirationDateTime"], "nextExpectedRanges" = (item0["nextExpectedRanges"] == null ? null : [for item2 in item0["nextExpectedRanges"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "attachments"                   = (var.attachments == null ? null : [for item0 in var.attachments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "contentType" = item0["contentType"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "name" = item0["name"], "size" = item0["size"] } : key1 => value1 if value1 != null }) if item0 != null])
    "body"                          = var.body
    "bodyLastModifiedDateTime"      = var.body_last_modified_date_time
    "categories"                    = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "checklistItems"                = (var.checklist_items == null ? null : [for item0 in var.checklist_items : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "checkedDateTime" = item0["checkedDateTime"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "isChecked" = item0["isChecked"] } : key1 => value1 if value1 != null }) if item0 != null])
    "completedDateTime"             = var.completed_date_time
    "createdDateTime"               = var.created_date_time
    "dueDateTime"                   = var.due_date_time
    "extensions"                    = (var.extensions == null ? null : [for item0 in var.extensions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "hasAttachments"                = var.has_attachments
    "importance"                    = var.importance
    "isReminderOn"                  = var.is_reminder_on
    "lastModifiedDateTime"          = var.last_modified_date_time
    "linkedResources"               = (var.linked_resources == null ? null : [for item0 in var.linked_resources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "applicationName" = item0["applicationName"], "displayName" = item0["displayName"], "externalId" = item0["externalId"], "webUrl" = item0["webUrl"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                   = var.odata_type
    "recurrence"                    = var.recurrence
    "reminderDateTime"              = var.reminder_date_time
    "singleValueExtendedProperties" = (var.single_value_extended_properties == null ? null : [for item0 in var.single_value_extended_properties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "startDateTime"                 = var.start_date_time
    "status"                        = var.status
    "title"                         = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/todo/lists/${urlencode(var.todo_task_list_id)}/tasks"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
