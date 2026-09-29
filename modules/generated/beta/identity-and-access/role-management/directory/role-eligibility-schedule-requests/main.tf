# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "action"            = var.action
    "appScopeId"        = var.app_scope_id
    "approvalId"        = var.approval_id
    "completedDateTime" = var.completed_date_time
    "createdBy"         = var.created_by
    "createdDateTime"   = var.created_date_time
    "customData"        = var.custom_data
    "directoryScopeId"  = var.directory_scope_id
    "isValidationOnly"  = var.is_validation_only
    "justification"     = var.justification
    "@odata.type"       = var.odata_type
    "principal"         = var.principal
    "principalId"       = var.principal_id
    "roleDefinition"    = var.role_definition
    "roleDefinitionId"  = var.role_definition_id
    "scheduleInfo"      = (var.schedule_info == null ? null : { for key0, value0 in { "@odata.type" = var.schedule_info["odata_type"], "expiration" = (var.schedule_info["expiration"] == null ? null : { for key1, value1 in { "@odata.type" = var.schedule_info["expiration"]["odata_type"], "duration" = var.schedule_info["expiration"]["duration"], "endDateTime" = var.schedule_info["expiration"]["endDateTime"], "type" = var.schedule_info["expiration"]["type"] } : key1 => value1 if value1 != null }), "recurrence" = (var.schedule_info["recurrence"] == null ? null : { for key1, value1 in { "@odata.type" = var.schedule_info["recurrence"]["odata_type"], "pattern" = (var.schedule_info["recurrence"]["pattern"] == null ? null : { for key2, value2 in { "@odata.type" = var.schedule_info["recurrence"]["pattern"]["odata_type"], "dayOfMonth" = var.schedule_info["recurrence"]["pattern"]["dayOfMonth"], "daysOfWeek" = (var.schedule_info["recurrence"]["pattern"]["daysOfWeek"] == null ? null : [for item3 in var.schedule_info["recurrence"]["pattern"]["daysOfWeek"] : item3 if item3 != null]), "firstDayOfWeek" = var.schedule_info["recurrence"]["pattern"]["firstDayOfWeek"], "index" = var.schedule_info["recurrence"]["pattern"]["index"], "interval" = var.schedule_info["recurrence"]["pattern"]["interval"], "month" = var.schedule_info["recurrence"]["pattern"]["month"], "type" = var.schedule_info["recurrence"]["pattern"]["type"] } : key2 => value2 if value2 != null }), "range" = (var.schedule_info["recurrence"]["range"] == null ? null : { for key2, value2 in { "@odata.type" = var.schedule_info["recurrence"]["range"]["odata_type"], "endDate" = var.schedule_info["recurrence"]["range"]["endDate"], "numberOfOccurrences" = var.schedule_info["recurrence"]["range"]["numberOfOccurrences"], "recurrenceTimeZone" = var.schedule_info["recurrence"]["range"]["recurrenceTimeZone"], "startDate" = var.schedule_info["recurrence"]["range"]["startDate"], "type" = var.schedule_info["recurrence"]["range"]["type"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }), "startDateTime" = var.schedule_info["startDateTime"] } : key0 => value0 if value0 != null })
    "status"            = var.status
    "targetSchedule"    = var.target_schedule
    "targetScheduleId"  = var.target_schedule_id
    "ticketInfo"        = (var.ticket_info == null ? null : { for key0, value0 in { "@odata.type" = var.ticket_info["odata_type"], "ticketApproverIdentityId" = var.ticket_info["ticketApproverIdentityId"], "ticketNumber" = var.ticket_info["ticketNumber"], "ticketSubmitterIdentityId" = var.ticket_info["ticketSubmitterIdentityId"], "ticketSystem" = var.ticket_info["ticketSystem"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "roleManagement/directory/roleEligibilityScheduleRequests"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
