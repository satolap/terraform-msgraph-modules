# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignedTo"             = var.assigned_to
    "createdBy"              = var.created_by
    "managerActionMessage"   = var.manager_action_message
    "@odata.type"            = var.odata_type
    "recipientActionMessage" = var.recipient_action_message
    "recipientShiftId"       = var.recipient_shift_id
    "recipientUserId"        = var.recipient_user_id
    "senderMessage"          = var.sender_message
    "senderShiftId"          = var.sender_shift_id
    "state"                  = var.state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/joinedTeams/${urlencode(var.team_id)}/schedule/swapShiftsChangeRequests"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
