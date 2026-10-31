# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actionAfterRetentionPeriod"    = var.actionAfterRetentionPeriod
    "behaviorDuringRetentionPeriod" = var.behaviorDuringRetentionPeriod
    "createdBy"                     = var.createdBy
    "createdDateTime"               = var.createdDateTime
    "defaultRecordBehavior"         = var.defaultRecordBehavior
    "descriptionForAdmins"          = var.descriptionForAdmins
    "descriptionForUsers"           = var.descriptionForUsers
    "descriptors"                   = var.descriptors
    "displayName"                   = var.displayName
    "dispositionReviewStages"       = (var.dispositionReviewStages == null ? null : [for item0 in var.dispositionReviewStages : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "reviewersEmailAddresses" = (item0["reviewersEmailAddresses"] == null ? null : [for item2 in item0["reviewersEmailAddresses"] : item2 if item2 != null]), "stageNumber" = item0["stageNumber"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isInUse"                       = var.isInUse
    "labelToBeApplied"              = var.labelToBeApplied
    "lastModifiedBy"                = var.lastModifiedBy
    "lastModifiedDateTime"          = var.lastModifiedDateTime
    "@odata.type"                   = var.odata_type
    "retentionDuration"             = var.retentionDuration
    "retentionEventType"            = var.retentionEventType
    "retentionTrigger"              = var.retentionTrigger
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "security/labels/retentionLabels"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["descriptors", "dispositionReviewStages", "retentionEventType"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
