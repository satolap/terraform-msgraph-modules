# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deviceMacAddress"     = var.device_mac_address
    "deviceName"           = var.device_name
    "deviceRegistrationId" = var.device_registration_id
    "deviceType"           = var.device_type
    "lastCheckInDateTime"  = var.last_check_in_date_time
    "@odata.type"          = var.odata_type
    "userId"               = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/windowsInformationProtectionDeviceRegistrations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
