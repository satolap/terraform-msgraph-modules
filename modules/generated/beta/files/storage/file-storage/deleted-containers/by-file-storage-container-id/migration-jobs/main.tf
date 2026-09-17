# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "containerInfo"  = (var.container_info == null ? null : { for key0, value0 in { "@odata.type" = var.container_info["odata_type"] } : key0 => value0 if value0 != null })
    "@odata.type"    = var.odata_type
    "progressEvents" = (var.progress_events == null ? null : [for item0 in var.progress_events : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "storage/fileStorage/deletedContainers/${urlencode(var.file_storage_container_id)}/migrationJobs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
