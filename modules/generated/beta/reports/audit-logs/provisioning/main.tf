# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "action"                 = var.action
    "activityDateTime"       = var.activity_date_time
    "changeId"               = var.change_id
    "cycleId"                = var.cycle_id
    "durationInMilliseconds" = var.duration_in_milliseconds
    "initiatedBy"            = (var.initiated_by == null ? null : { for key0, value0 in { "@odata.type" = var.initiated_by["odata_type"], "displayName" = var.initiated_by["displayName"], "id" = var.initiated_by["id"], "initiatorType" = var.initiated_by["initiatorType"] } : key0 => value0 if value0 != null })
    "jobId"                  = var.job_id
    "modifiedProperties"     = (var.modified_properties == null ? null : [for item0 in var.modified_properties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "newValue" = item0["newValue"], "oldValue" = item0["oldValue"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"            = var.odata_type
    "provisioningAction"     = var.provisioning_action
    "provisioningStatusInfo" = (var.provisioning_status_info == null ? null : { for key0, value0 in { "@odata.type" = var.provisioning_status_info["odata_type"], "errorInformation" = (var.provisioning_status_info["errorInformation"] == null ? null : { for key1, value1 in { "@odata.type" = var.provisioning_status_info["errorInformation"]["odata_type"], "additionalDetails" = var.provisioning_status_info["errorInformation"]["additionalDetails"], "errorCategory" = var.provisioning_status_info["errorInformation"]["errorCategory"], "errorCode" = var.provisioning_status_info["errorInformation"]["errorCode"], "reason" = var.provisioning_status_info["errorInformation"]["reason"], "recommendedAction" = var.provisioning_status_info["errorInformation"]["recommendedAction"] } : key1 => value1 if value1 != null }), "status" = var.provisioning_status_info["status"] } : key0 => value0 if value0 != null })
    "provisioningSteps"      = (var.provisioning_steps == null ? null : [for item0 in var.provisioning_steps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "details" = item0["details"], "name" = item0["name"], "provisioningStepType" = item0["provisioningStepType"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "servicePrincipal"       = (var.service_principal == null ? null : { for key0, value0 in { "@odata.type" = var.service_principal["odata_type"], "displayName" = var.service_principal["displayName"], "id" = var.service_principal["id"] } : key0 => value0 if value0 != null })
    "sourceIdentity"         = (var.source_identity == null ? null : { for key0, value0 in { "@odata.type" = var.source_identity["odata_type"], "details" = var.source_identity["details"], "displayName" = var.source_identity["displayName"], "id" = var.source_identity["id"], "identityType" = var.source_identity["identityType"] } : key0 => value0 if value0 != null })
    "sourceSystem"           = (var.source_system == null ? null : { for key0, value0 in { "@odata.type" = var.source_system["odata_type"], "details" = var.source_system["details"], "displayName" = var.source_system["displayName"], "id" = var.source_system["id"] } : key0 => value0 if value0 != null })
    "statusInfo"             = var.status_info
    "targetIdentity"         = (var.target_identity == null ? null : { for key0, value0 in { "@odata.type" = var.target_identity["odata_type"], "details" = var.target_identity["details"], "displayName" = var.target_identity["displayName"], "id" = var.target_identity["id"], "identityType" = var.target_identity["identityType"] } : key0 => value0 if value0 != null })
    "targetSystem"           = (var.target_system == null ? null : { for key0, value0 in { "@odata.type" = var.target_system["odata_type"], "details" = var.target_system["details"], "displayName" = var.target_system["displayName"], "id" = var.target_system["id"] } : key0 => value0 if value0 != null })
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
