# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"                            = var.created_by
    "createdDateTime"                      = var.created_date_time
    "displayName"                          = var.display_name
    "driveInclusionRules"                  = (var.drive_inclusion_rules == null ? null : [for item0 in var.drive_inclusion_rules : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "driveExpression" = item0["driveExpression"], "error" = item0["error"], "isAutoApplyEnabled" = item0["isAutoApplyEnabled"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "driveProtectionUnits"                 = (var.drive_protection_units == null ? null : [for item0 in var.drive_protection_units : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "directoryObjectId" = item0["directoryObjectId"], "error" = item0["error"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "offboardRequestedDateTime" = item0["offboardRequestedDateTime"], "policyId" = item0["policyId"], "protectionSources" = item0["protectionSources"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "driveProtectionUnitsBulkAdditionJobs" = (var.drive_protection_units_bulk_addition_jobs == null ? null : [for item0 in var.drive_protection_units_bulk_addition_jobs : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "directoryObjectIds" = (item0["directoryObjectIds"] == null ? null : [for item2 in item0["directoryObjectIds"] : item2 if item2 != null]), "displayName" = item0["displayName"], "drives" = (item0["drives"] == null ? null : [for item2 in item0["drives"] : item2 if item2 != null]), "error" = item0["error"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isEnabled"                            = var.is_enabled
    "lastModifiedBy"                       = var.last_modified_by
    "lastModifiedDateTime"                 = var.last_modified_date_time
    "@odata.type"                          = var.odata_type
    "protectionPolicyArtifactCount"        = var.protection_policy_artifact_count
    "retentionSettings"                    = (var.retention_settings == null ? null : [for item0 in var.retention_settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "interval" = item0["interval"], "period" = item0["period"] } : key1 => value1 if value1 != null }) if item0 != null])
    "status"                               = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/backupRestore/oneDriveForBusinessProtectionPolicies"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
