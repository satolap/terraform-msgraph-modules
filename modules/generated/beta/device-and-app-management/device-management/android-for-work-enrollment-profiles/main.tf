# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accountId"               = var.account_id
    "createdDateTime"         = var.created_date_time
    "description"             = var.description
    "displayName"             = var.display_name
    "enrolledDeviceCount"     = var.enrolled_device_count
    "lastModifiedDateTime"    = var.last_modified_date_time
    "@odata.type"             = var.odata_type
    "qrCodeContent"           = var.qr_code_content
    "qrCodeImage"             = var.qr_code_image
    "tokenExpirationDateTime" = var.token_expiration_date_time
    "tokenValue"              = var.token_value
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/androidForWorkEnrollmentProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
