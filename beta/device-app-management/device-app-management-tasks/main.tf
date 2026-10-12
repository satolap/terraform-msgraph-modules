# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignedTo"      = var.assigned_to
    "category"        = var.category
    "createdDateTime" = var.created_date_time
    "creator"         = var.creator
    "creatorNotes"    = var.creator_notes
    "description"     = var.description
    "displayName"     = var.display_name
    "dueDateTime"     = var.due_date_time
    "@odata.type"     = var.odata_type
    "priority"        = var.priority
    "status"          = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/deviceAppManagementTasks"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
