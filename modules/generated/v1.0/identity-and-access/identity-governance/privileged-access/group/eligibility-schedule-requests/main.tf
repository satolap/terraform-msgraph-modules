# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessId"          = var.access_id
    "action"            = var.action
    "approvalId"        = var.approval_id
    "completedDateTime" = var.completed_date_time
    "createdBy"         = var.created_by
    "createdDateTime"   = var.created_date_time
    "customData"        = var.custom_data
    "group"             = var.group
    "groupId"           = var.group_id
    "isValidationOnly"  = var.is_validation_only
    "justification"     = var.justification
    "@odata.type"       = var.odata_type
    "principal"         = var.principal
    "principalId"       = var.principal_id
    "scheduleInfo"      = var.schedule_info
    "status"            = var.status
    "targetSchedule"    = var.target_schedule
    "targetScheduleId"  = var.target_schedule_id
    "ticketInfo"        = var.ticket_info
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/privilegedAccess/group/eligibilityScheduleRequests"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
