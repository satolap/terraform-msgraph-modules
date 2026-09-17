# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "cloudPcFailurePercentage" = var.cloud_pc_failure_percentage
    "cloudPcRoundTripTime"     = var.cloud_pc_round_trip_time
    "cloudPcSignInTime"        = var.cloud_pc_sign_in_time
    "coreBootTime"             = var.core_boot_time
    "coreSignInTime"           = var.core_sign_in_time
    "deviceCount"              = var.device_count
    "deviceId"                 = var.device_id
    "deviceName"               = var.device_name
    "manufacturer"             = var.manufacturer
    "model"                    = var.model
    "@odata.type"              = var.odata_type
    "remoteSignInTime"         = var.remote_sign_in_time
    "userPrincipalName"        = var.user_principal_name
    "virtualNetwork"           = var.virtual_network
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/userExperienceAnalyticsRemoteConnection"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
