# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "boardSupportPackageVersion" = var.board_support_package_version
    "description"                = var.description
    "deviceModel"                = var.device_model
    "@odata.type"                = var.odata_type
    "osVersion"                  = var.os_version
    "patchVersion"               = var.patch_version
    "releaseNotesUrl"            = var.release_notes_url
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/zebraFotaArtifacts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
