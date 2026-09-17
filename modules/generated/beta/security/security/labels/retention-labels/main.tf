# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actionAfterRetentionPeriod"    = var.action_after_retention_period
    "behaviorDuringRetentionPeriod" = var.behavior_during_retention_period
    "createdBy"                     = var.created_by
    "createdDateTime"               = var.created_date_time
    "defaultRecordBehavior"         = var.default_record_behavior
    "descriptionForAdmins"          = var.description_for_admins
    "descriptionForUsers"           = var.description_for_users
    "descriptors"                   = var.descriptors
    "displayName"                   = var.display_name
    "dispositionReviewStages"       = (var.disposition_review_stages == null ? null : [for item0 in var.disposition_review_stages : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "reviewersEmailAddresses" = (item0["reviewersEmailAddresses"] == null ? null : [for item2 in item0["reviewersEmailAddresses"] : item2 if item2 != null]), "stageNumber" = item0["stageNumber"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isInUse"                       = var.is_in_use
    "labelToBeApplied"              = var.label_to_be_applied
    "lastModifiedBy"                = var.last_modified_by
    "lastModifiedDateTime"          = var.last_modified_date_time
    "@odata.type"                   = var.odata_type
    "retentionDuration"             = var.retention_duration
    "retentionEventType"            = var.retention_event_type
    "retentionTrigger"              = var.retention_trigger
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/labels/retentionLabels"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
