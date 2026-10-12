# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "autoPilotProfileAssigned" = var.auto_pilot_profile_assigned
    "autoPilotRegistered"      = var.auto_pilot_registered
    "azureAdJoinType"          = var.azure_ad_join_type
    "azureAdRegistered"        = var.azure_ad_registered
    "deviceName"               = var.device_name
    "managedBy"                = var.managed_by
    "manufacturer"             = var.manufacturer
    "model"                    = var.model
    "@odata.type"              = var.odata_type
    "serialNumber"             = var.serial_number
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/userExperienceAnalyticsNotAutopilotReadyDevice"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
