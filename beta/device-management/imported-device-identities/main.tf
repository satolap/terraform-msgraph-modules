# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime"            = var.created_date_time
    "description"                = var.description
    "enrollmentState"            = var.enrollment_state
    "importedDeviceIdentifier"   = var.imported_device_identifier
    "importedDeviceIdentityType" = var.imported_device_identity_type
    "lastContactedDateTime"      = var.last_contacted_date_time
    "lastModifiedDateTime"       = var.last_modified_date_time
    "@odata.type"                = var.odata_type
    "platform"                   = var.platform
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/importedDeviceIdentities"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
