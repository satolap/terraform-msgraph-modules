# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attributes"     = (var.attributes == null ? null : [for item0 in var.attributes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "destination" = item0["destination"], "isEditable" = item0["isEditable"], "isPersistedOnAssignmentRemoval" = item0["isPersistedOnAssignmentRemoval"], "name" = item0["name"], "source" = item0["source"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"    = var.description
    "displayName"    = var.display_name
    "environment"    = var.environment
    "@odata.type"    = var.odata_type
    "originId"       = var.origin_id
    "originSystem"   = var.origin_system
    "uploadSessions" = (var.upload_sessions == null ? null : [for item0 in var.upload_sessions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "data" = item0["data"], "files" = (item0["files"] == null ? null : [for item2 in item0["files"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "name" = item2["name"] } : key3 => value3 if value3 != null }) if item2 != null]), "isUploadDone" = item0["isUploadDone"], "referenceId" = item0["referenceId"], "stats" = (item0["stats"] == null ? null : { for key2, value2 in { "@odata.type" = item0["stats"]["odata_type"], "filesUploaded" = item0["stats"]["filesUploaded"], "totalBytesUploaded" = item0["stats"]["totalBytesUploaded"] } : key2 => value2 if value2 != null }), "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/catalogs/${urlencode(var.access_package_catalog_id)}/resources"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
