# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignedTo"             = var.assigned_to
    "createdBy"              = var.created_by
    "managerActionMessage"   = var.manager_action_message
    "@odata.type"            = var.odata_type
    "recipientActionMessage" = var.recipient_action_message
    "recipientUserId"        = var.recipient_user_id
    "senderMessage"          = var.sender_message
    "senderShiftId"          = var.sender_shift_id
    "state"                  = var.state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teamwork/teamTemplates/${urlencode(var.team_template_id)}/definitions/${urlencode(var.team_template_definition_id)}/teamDefinition/schedule/offerShiftRequests"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
