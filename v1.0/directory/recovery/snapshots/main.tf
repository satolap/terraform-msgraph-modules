# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime"     = var.created_date_time
    "@odata.type"         = var.odata_type
    "recoveryJobs"        = (var.recovery_jobs == null ? null : [for item0 in var.recovery_jobs : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "filteringCriteria" = item0["filteringCriteria"], "jobCompletionDateTime" = item0["jobCompletionDateTime"], "jobStartDateTime" = item0["jobStartDateTime"], "status" = item0["status"], "targetStateDateTime" = item0["targetStateDateTime"], "totalChangedLinksCalculated" = item0["totalChangedLinksCalculated"], "totalChangedObjectsCalculated" = item0["totalChangedObjectsCalculated"], "totalFailedChanges" = item0["totalFailedChanges"], "totalLinksModified" = item0["totalLinksModified"], "totalObjectsModified" = item0["totalObjectsModified"] } : key1 => value1 if value1 != null }) if item0 != null])
    "recoveryPreviewJobs" = (var.recovery_preview_jobs == null ? null : [for item0 in var.recovery_preview_jobs : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "filteringCriteria" = item0["filteringCriteria"], "jobCompletionDateTime" = item0["jobCompletionDateTime"], "jobStartDateTime" = item0["jobStartDateTime"], "status" = item0["status"], "targetStateDateTime" = item0["targetStateDateTime"], "totalChangedLinksCalculated" = item0["totalChangedLinksCalculated"], "totalChangedObjectsCalculated" = item0["totalChangedObjectsCalculated"] } : key1 => value1 if value1 != null }) if item0 != null])
    "totalChangedObjects" = var.total_changed_objects
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/recovery/snapshots"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
