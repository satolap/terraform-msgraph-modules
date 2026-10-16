# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignees"           = (var.assignees == null ? null : [for item0 in var.assignees : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "email" = item0["email"], "id" = item0["id"] } : key1 => value1 if value1 != null }) if item0 != null])
    "changes"             = (var.changes == null ? null : [for item0 in var.changes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignee" = (item0["assignee"] == null ? null : { for key2, value2 in { "@odata.type" = item0["assignee"]["odata_type"], "displayName" = item0["assignee"]["displayName"], "email" = item0["assignee"]["email"], "id" = item0["assignee"]["id"] } : key2 => value2 if value2 != null }), "changedBy" = (item0["changedBy"] == null ? null : { for key2, value2 in { "@odata.type" = item0["changedBy"]["odata_type"], "displayName" = item0["changedBy"]["displayName"], "email" = item0["changedBy"]["email"], "id" = item0["changedBy"]["id"] } : key2 => value2 if value2 != null }), "commentId" = item0["commentId"], "createdDateTime" = item0["createdDateTime"], "dueDateTime" = item0["dueDateTime"], "percentComplete" = item0["percentComplete"], "priority" = item0["priority"], "startDateTime" = item0["startDateTime"], "title" = item0["title"], "type" = item0["type"], "undoChangeId" = item0["undoChangeId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "comment"             = var.comment
    "completedBy"         = (var.completed_by == null ? null : { for key0, value0 in { "@odata.type" = var.completed_by["odata_type"], "displayName" = var.completed_by["displayName"], "email" = var.completed_by["email"], "id" = var.completed_by["id"] } : key0 => value0 if value0 != null })
    "completedDateTime"   = var.completed_date_time
    "createdBy"           = (var.created_by == null ? null : { for key0, value0 in { "@odata.type" = var.created_by["odata_type"], "displayName" = var.created_by["displayName"], "email" = var.created_by["email"], "id" = var.created_by["id"] } : key0 => value0 if value0 != null })
    "createdDateTime"     = var.created_date_time
    "@odata.type"         = var.odata_type
    "percentComplete"     = var.percent_complete
    "priority"            = var.priority
    "startAndDueDateTime" = (var.start_and_due_date_time == null ? null : { for key0, value0 in { "@odata.type" = var.start_and_due_date_time["odata_type"], "dueDateTime" = var.start_and_due_date_time["dueDateTime"], "startDateTime" = var.start_and_due_date_time["startDateTime"] } : key0 => value0 if value0 != null })
    "title"               = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "drives/${urlencode(var.drive_id)}/items/${urlencode(var.drive_item_id)}/workbook/worksheets/${urlencode(var.workbook_worksheet_id)}/tasks"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
