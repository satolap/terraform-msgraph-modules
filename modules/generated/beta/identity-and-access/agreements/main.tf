# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"                       = var.display_name
    "file"                              = var.file
    "files"                             = (var.files == null ? null : [for item0 in var.files : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "isMajorVersion" = item0["isMajorVersion"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isPerDeviceAcceptanceRequired"     = var.is_per_device_acceptance_required
    "isViewingBeforeAcceptanceRequired" = var.is_viewing_before_acceptance_required
    "@odata.type"                       = var.odata_type
    "termsExpiration"                   = var.terms_expiration
    "userReacceptRequiredFrequency"     = var.user_reaccept_required_frequency
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "agreements"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
