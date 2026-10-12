# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "lastCheckInDateTime"          = var.last_check_in_date_time
    "@odata.type"                  = var.odata_type
    "status"                       = var.status
    "targetedDeviceMacAddress"     = var.targeted_device_mac_address
    "targetedDeviceName"           = var.targeted_device_name
    "targetedDeviceRegistrationId" = var.targeted_device_registration_id
    "targetedUserId"               = var.targeted_user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/windowsInformationProtectionWipeActions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
