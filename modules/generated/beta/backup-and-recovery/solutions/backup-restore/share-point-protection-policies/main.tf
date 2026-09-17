# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "billingPolicyId"                     = var.billing_policy_id
    "createdBy"                           = var.created_by
    "createdDateTime"                     = var.created_date_time
    "displayName"                         = var.display_name
    "isEnabled"                           = var.is_enabled
    "lastModifiedBy"                      = var.last_modified_by
    "lastModifiedDateTime"                = var.last_modified_date_time
    "@odata.type"                         = var.odata_type
    "offboardRequestedDateTime"           = var.offboard_requested_date_time
    "protectionMode"                      = var.protection_mode
    "protectionPolicyArtifactCount"       = var.protection_policy_artifact_count
    "retentionSettings"                   = (var.retention_settings == null ? null : [for item0 in var.retention_settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "interval" = item0["interval"], "period" = item0["period"] } : key1 => value1 if value1 != null }) if item0 != null])
    "siteExclusionUnits"                  = (var.site_exclusion_units == null ? null : [for item0 in var.site_exclusion_units : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "error" = item0["error"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "policyId" = item0["policyId"], "siteId" = item0["siteId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "siteExclusionUnitsBulkAdditionJobs"  = (var.site_exclusion_units_bulk_addition_jobs == null ? null : [for item0 in var.site_exclusion_units_bulk_addition_jobs : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "error" = item0["error"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "siteWebUrls" = (item0["siteWebUrls"] == null ? null : [for item2 in item0["siteWebUrls"] : item2 if item2 != null]), "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "siteInclusionRules"                  = (var.site_inclusion_rules == null ? null : [for item0 in var.site_inclusion_rules : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "error" = item0["error"], "isAutoApplyEnabled" = item0["isAutoApplyEnabled"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "siteExpression" = item0["siteExpression"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "siteProtectionUnits"                 = (var.site_protection_units == null ? null : [for item0 in var.site_protection_units : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "backupRetentionPeriodInDays" = item0["backupRetentionPeriodInDays"], "billingPolicyId" = item0["billingPolicyId"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "error" = item0["error"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "offboardRequestedDateTime" = item0["offboardRequestedDateTime"], "policyId" = item0["policyId"], "protectionSources" = item0["protectionSources"], "siteId" = item0["siteId"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "siteProtectionUnitsBulkAdditionJobs" = (var.site_protection_units_bulk_addition_jobs == null ? null : [for item0 in var.site_protection_units_bulk_addition_jobs : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "error" = item0["error"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "siteIds" = (item0["siteIds"] == null ? null : [for item2 in item0["siteIds"] : item2 if item2 != null]), "siteWebUrls" = (item0["siteWebUrls"] == null ? null : [for item2 in item0["siteWebUrls"] : item2 if item2 != null]), "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "status"                              = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/backupRestore/sharePointProtectionPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
