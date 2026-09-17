# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "classification"       = var.classification
    "details"              = (var.details == null ? null : [for item0 in var.details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "endDateTime"          = var.end_date_time
    "feature"              = var.feature
    "featureGroup"         = var.feature_group
    "impactDescription"    = var.impact_description
    "isResolved"           = var.is_resolved
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "origin"               = var.origin
    "posts"                = (var.posts == null ? null : [for item0 in var.posts : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "postType" = item0["postType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "service"              = var.service
    "startDateTime"        = var.start_date_time
    "status"               = var.status
    "title"                = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/serviceAnnouncement/issues"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
