# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "action"                 = var.action
    "activityDateTime"       = var.activity_date_time
    "changeId"               = var.change_id
    "cycleId"                = var.cycle_id
    "durationInMilliseconds" = var.duration_in_milliseconds
    "initiatedBy"            = var.initiated_by
    "jobId"                  = var.job_id
    "modifiedProperties"     = (var.modified_properties == null ? null : [for item0 in var.modified_properties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "newValue" = item0["newValue"], "oldValue" = item0["oldValue"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"            = var.odata_type
    "provisioningAction"     = var.provisioning_action
    "provisioningStatusInfo" = var.provisioning_status_info
    "provisioningSteps"      = (var.provisioning_steps == null ? null : [for item0 in var.provisioning_steps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "details" = item0["details"], "name" = item0["name"], "provisioningStepType" = item0["provisioningStepType"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "servicePrincipal"       = var.service_principal
    "sourceIdentity"         = var.source_identity
    "sourceSystem"           = var.source_system
    "statusInfo"             = var.status_info
    "targetIdentity"         = var.target_identity
    "targetSystem"           = var.target_system
    "tenantId"               = var.tenant_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "auditLogs/provisioning"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
