# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedAudiences"     = var.allowed_audiences
    "completionMonthYear"  = var.completion_month_year
    "createdBy"            = var.created_by
    "createdDateTime"      = var.created_date_time
    "endMonthYear"         = var.end_month_year
    "source"               = var.graph_source
    "inference"            = var.inference
    "institution"          = var.institution
    "isSearchable"         = var.is_searchable
    "lastModifiedBy"       = var.last_modified_by
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "program"              = var.program
    "sources"              = (var.sources == null ? null : [for item0 in var.sources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isDefaultSource" = item0["isDefaultSource"], "properties" = (item0["properties"] == null ? null : [for item2 in item0["properties"] : item2 if item2 != null]), "sourceId" = item0["sourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "startMonthYear"       = var.start_month_year
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/profile/educationalActivities"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
