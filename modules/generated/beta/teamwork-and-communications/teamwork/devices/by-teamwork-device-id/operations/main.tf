# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "completedDateTime"  = var.completed_date_time
    "createdBy"          = var.created_by
    "createdDateTime"    = var.created_date_time
    "error"              = var.error
    "lastActionBy"       = var.last_action_by
    "lastActionDateTime" = var.last_action_date_time
    "@odata.type"        = var.odata_type
    "operationType"      = var.operation_type
    "startedDateTime"    = var.started_date_time
    "status"             = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teamwork/devices/${urlencode(var.teamwork_device_id)}/operations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
