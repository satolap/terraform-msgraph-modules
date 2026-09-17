# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "issues"      = (var.issues == null ? null : [for item0 in var.issues : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "classification" = item0["classification"], "details" = (item0["details"] == null ? null : [for item2 in item0["details"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "name" = item2["name"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "endDateTime" = item0["endDateTime"], "feature" = item0["feature"], "featureGroup" = item0["featureGroup"], "impactDescription" = item0["impactDescription"], "isResolved" = item0["isResolved"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "origin" = item0["origin"], "posts" = (item0["posts"] == null ? null : [for item2 in item0["posts"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "createdDateTime" = item2["createdDateTime"], "description" = item2["description"], "postType" = item2["postType"] } : key3 => value3 if value3 != null }) if item2 != null]), "service" = item0["service"], "startDateTime" = item0["startDateTime"], "status" = item0["status"], "title" = item0["title"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type" = var.odata_type
    "service"     = var.service
    "status"      = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/serviceAnnouncement/healthOverviews"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
