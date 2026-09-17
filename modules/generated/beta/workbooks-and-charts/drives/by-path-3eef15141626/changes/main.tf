# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignee"        = var.assignee
    "changedBy"       = (var.changed_by == null ? null : { for key0, value0 in { "@odata.type" = var.changed_by["odata_type"], "displayName" = var.changed_by["displayName"], "email" = var.changed_by["email"], "id" = var.changed_by["id"] } : key0 => value0 if value0 != null })
    "commentId"       = var.comment_id
    "createdDateTime" = var.created_date_time
    "dueDateTime"     = var.due_date_time
    "@odata.type"     = var.odata_type
    "percentComplete" = var.percent_complete
    "priority"        = var.priority
    "startDateTime"   = var.start_date_time
    "title"           = var.title
    "type"            = var.type
    "undoChangeId"    = var.undo_change_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "drives/${urlencode(var.drive_id)}/items/${urlencode(var.drive_item_id)}/workbook/worksheets/${urlencode(var.workbook_worksheet_id)}/tasks/${urlencode(var.workbook_document_task_id)}/comment/replies/${urlencode(var.workbook_comment_reply_id)}/task/changes"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
