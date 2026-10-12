# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignmentState"   = var.assignment_state
    "duration"          = var.duration
    "@odata.type"       = var.odata_type
    "reason"            = var.reason
    "requestedDateTime" = var.requested_date_time
    "roleId"            = var.role_id
    "roleInfo"          = var.role_info
    "schedule"          = (var.schedule == null ? null : { for key0, value0 in { "@odata.type" = var.schedule["odata_type"], "duration" = var.schedule["duration"], "endDateTime" = var.schedule["endDateTime"], "startDateTime" = var.schedule["startDateTime"], "type" = var.schedule["type"] } : key0 => value0 if value0 != null })
    "status"            = var.status
    "ticketNumber"      = var.ticket_number
    "ticketSystem"      = var.ticket_system
    "type"              = var.type
    "userId"            = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "privilegedRoleAssignmentRequests"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
