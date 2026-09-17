# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "checkedDateTime" = var.checked_date_time
    "createdDateTime" = var.created_date_time
    "displayName"     = var.display_name
    "isChecked"       = var.is_checked
    "@odata.type"     = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/todo/lists/${urlencode(var.todo_task_list_id)}/tasks/${urlencode(var.todo_task_id)}/checklistItems"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
