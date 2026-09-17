# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "data"         = var.data
    "files"        = (var.files == null ? null : [for item0 in var.files : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isUploadDone" = var.is_upload_done
    "@odata.type"  = var.odata_type
    "referenceId"  = var.reference_id
    "stats"        = (var.stats == null ? null : { for key0, value0 in { "@odata.type" = var.stats["odata_type"], "filesUploaded" = var.stats["filesUploaded"], "totalBytesUploaded" = var.stats["totalBytesUploaded"] } : key0 => value0 if value0 != null })
    "status"       = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/catalogs/${urlencode(var.access_package_catalog_id)}/resourceRoles/${urlencode(var.access_package_resource_role_id)}/resource/uploadSessions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
