# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "answers"                         = (var.answers == null ? null : [for item0 in var.answers : item0 if item0 != null])
    "assignment"                      = var.assignment
    "customExtensionCalloutInstances" = (var.custom_extension_callout_instances == null ? null : [for item0 in var.custom_extension_callout_instances : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customExtensionId" = item0["customExtensionId"], "detail" = item0["detail"], "externalCorrelationId" = item0["externalCorrelationId"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "justification"                   = var.justification
    "@odata.type"                     = var.odata_type
    "parameters"                      = (var.parameters == null ? null : { for key0, value0 in { "@odata.type" = var.parameters["odata_type"], "bypassApproval" = var.parameters["bypassApproval"] } : key0 => value0 if value0 != null })
    "requestType"                     = var.request_type
    "schedule"                        = (var.schedule == null ? null : { for key0, value0 in { "@odata.type" = var.schedule["odata_type"], "expiration" = (var.schedule["expiration"] == null ? null : { for key1, value1 in { "@odata.type" = var.schedule["expiration"]["odata_type"], "duration" = var.schedule["expiration"]["duration"], "endDateTime" = var.schedule["expiration"]["endDateTime"], "type" = var.schedule["expiration"]["type"] } : key1 => value1 if value1 != null }), "recurrence" = (var.schedule["recurrence"] == null ? null : { for key1, value1 in { "@odata.type" = var.schedule["recurrence"]["odata_type"], "pattern" = (var.schedule["recurrence"]["pattern"] == null ? null : { for key2, value2 in { "@odata.type" = var.schedule["recurrence"]["pattern"]["odata_type"], "dayOfMonth" = var.schedule["recurrence"]["pattern"]["dayOfMonth"], "daysOfWeek" = (var.schedule["recurrence"]["pattern"]["daysOfWeek"] == null ? null : [for item3 in var.schedule["recurrence"]["pattern"]["daysOfWeek"] : item3 if item3 != null]), "firstDayOfWeek" = var.schedule["recurrence"]["pattern"]["firstDayOfWeek"], "index" = var.schedule["recurrence"]["pattern"]["index"], "interval" = var.schedule["recurrence"]["pattern"]["interval"], "month" = var.schedule["recurrence"]["pattern"]["month"], "type" = var.schedule["recurrence"]["pattern"]["type"] } : key2 => value2 if value2 != null }), "range" = (var.schedule["recurrence"]["range"] == null ? null : { for key2, value2 in { "@odata.type" = var.schedule["recurrence"]["range"]["odata_type"], "endDate" = var.schedule["recurrence"]["range"]["endDate"], "numberOfOccurrences" = var.schedule["recurrence"]["range"]["numberOfOccurrences"], "recurrenceTimeZone" = var.schedule["recurrence"]["range"]["recurrenceTimeZone"], "startDate" = var.schedule["recurrence"]["range"]["startDate"], "type" = var.schedule["recurrence"]["range"]["type"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }), "startDateTime" = var.schedule["startDateTime"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/assignmentRequests"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
