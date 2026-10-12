# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignedTo"           = var.assigned_to
    "createdBy"            = var.created_by
    "endDateTime"          = var.end_date_time
    "managerActionMessage" = var.manager_action_message
    "@odata.type"          = var.odata_type
    "senderMessage"        = var.sender_message
    "startDateTime"        = var.start_date_time
    "state"                = var.state
    "timeOffReasonId"      = var.time_off_reason_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "groups/${urlencode(var.group_id)}/team/schedule/timeOffRequests"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
