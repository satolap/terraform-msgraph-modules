# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "addToReviewSetOperation"         = var.addToReviewSetOperation
    "additionalSources"               = (var.additionalSources == null ? null : [for item0 in var.additionalSources : item0 if item0 != null])
    "contentQuery"                    = var.contentQuery
    "createdBy"                       = var.createdBy
    "createdDateTime"                 = var.createdDateTime
    "custodianSources"                = (var.custodianSources == null ? null : [for item0 in var.custodianSources : item0 if item0 != null])
    "dataSourceScopes"                = var.dataSourceScopes
    "description"                     = var.description
    "displayName"                     = var.displayName
    "lastEstimateStatisticsOperation" = var.lastEstimateStatisticsOperation
    "lastModifiedBy"                  = var.lastModifiedBy
    "lastModifiedDateTime"            = var.lastModifiedDateTime
    "noncustodialSources"             = (var.noncustodialSources == null ? null : [for item0 in var.noncustodialSources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "applyHoldToSource" = item0["applyHoldToSource"], "createdDateTime" = item0["createdDateTime"], "dataSource" = item0["dataSource"], "displayName" = item0["displayName"], "holdStatus" = item0["holdStatus"], "lastIndexOperation" = item0["lastIndexOperation"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "releasedDateTime" = item0["releasedDateTime"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                     = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "compliance/ediscovery/cases/${urlencode(var.case-id)}/sourceCollections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["addToReviewSetOperation", "additionalSources", "custodianSources", "lastEstimateStatisticsOperation", "noncustodialSources"], name)])]))))] } : null

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
