# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "addToReviewSetOperation"         = var.add_to_review_set_operation
    "additionalSources"               = (var.additional_sources == null ? null : [for item0 in var.additional_sources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "holdStatus" = item0["holdStatus"] } : key1 => value1 if value1 != null }) if item0 != null])
    "contentQuery"                    = var.content_query
    "createdBy"                       = var.created_by
    "createdDateTime"                 = var.created_date_time
    "custodianSources"                = (var.custodian_sources == null ? null : [for item0 in var.custodian_sources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "holdStatus" = item0["holdStatus"] } : key1 => value1 if value1 != null }) if item0 != null])
    "dataSourceScopes"                = var.data_source_scopes
    "description"                     = var.description
    "displayName"                     = var.display_name
    "lastEstimateStatisticsOperation" = var.last_estimate_statistics_operation
    "lastModifiedBy"                  = var.last_modified_by
    "lastModifiedDateTime"            = var.last_modified_date_time
    "noncustodialSources"             = (var.noncustodial_sources == null ? null : [for item0 in var.noncustodial_sources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "dataSource" = item0["dataSource"], "displayName" = item0["displayName"], "holdStatus" = item0["holdStatus"], "lastIndexOperation" = item0["lastIndexOperation"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "releasedDateTime" = item0["releasedDateTime"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                     = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/cases/ediscoveryCases/${urlencode(var.ediscovery_case_id)}/searches"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
