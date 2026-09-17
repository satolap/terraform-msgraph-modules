# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "completedDateTime"                        = var.completed_date_time
    "createdBy"                                = var.created_by
    "createdDateTime"                          = var.created_date_time
    "error"                                    = var.error
    "granularSiteRestoreArtifacts"             = (var.granular_site_restore_artifacts == null ? null : [for item0 in var.granular_site_restore_artifacts : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "browseSessionId" = item0["browseSessionId"], "completionDateTime" = item0["completionDateTime"], "destinationType" = item0["destinationType"], "error" = item0["error"], "restorePointDateTime" = item0["restorePointDateTime"], "restoredItemKey" = item0["restoredItemKey"], "restoredItemPath" = item0["restoredItemPath"], "restoredItemWebUrl" = item0["restoredItemWebUrl"], "siteId" = item0["siteId"], "startDateTime" = item0["startDateTime"], "status" = item0["status"], "webUrl" = item0["webUrl"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastModifiedBy"                           = var.last_modified_by
    "lastModifiedDateTime"                     = var.last_modified_date_time
    "@odata.type"                              = var.odata_type
    "policyId"                                 = var.policy_id
    "restoreJobType"                           = var.restore_job_type
    "restoreSessionArtifactCount"              = var.restore_session_artifact_count
    "siteRestoreArtifacts"                     = (var.site_restore_artifacts == null ? null : [for item0 in var.site_restore_artifacts : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "completionDateTime" = item0["completionDateTime"], "destinationType" = item0["destinationType"], "error" = item0["error"], "restorePoint" = item0["restorePoint"], "restoredSiteId" = item0["restoredSiteId"], "startDateTime" = item0["startDateTime"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "siteRestoreArtifactsBulkAdditionRequests" = (var.site_restore_artifacts_bulk_addition_requests == null ? null : [for item0 in var.site_restore_artifacts_bulk_addition_requests : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "destinationType" = item0["destinationType"], "displayName" = item0["displayName"], "error" = item0["error"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "protectionTimePeriod" = item0["protectionTimePeriod"], "protectionUnitIds" = (item0["protectionUnitIds"] == null ? null : [for item2 in item0["protectionUnitIds"] : item2 if item2 != null]), "restorePointPreference" = item0["restorePointPreference"], "siteIds" = (item0["siteIds"] == null ? null : [for item2 in item0["siteIds"] : item2 if item2 != null]), "siteWebUrls" = (item0["siteWebUrls"] == null ? null : [for item2 in item0["siteWebUrls"] : item2 if item2 != null]), "status" = item0["status"], "tags" = item0["tags"] } : key1 => value1 if value1 != null }) if item0 != null])
    "status"                                   = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/backupRestore/sharePointRestoreSessions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
