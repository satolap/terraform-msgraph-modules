# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "compliantDeviceCount"          = var.compliant_device_count
    "conflictDeviceCount"           = var.conflict_device_count
    "deviceComplianceSettingStates" = (var.device_compliance_setting_states == null ? null : [for item0 in var.device_compliance_setting_states : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "complianceGracePeriodExpirationDateTime" = item0["complianceGracePeriodExpirationDateTime"], "deviceId" = item0["deviceId"], "deviceModel" = item0["deviceModel"], "deviceName" = item0["deviceName"], "platformType" = item0["platformType"], "setting" = item0["setting"], "settingName" = item0["settingName"], "state" = item0["state"], "userEmail" = item0["userEmail"], "userId" = item0["userId"], "userName" = item0["userName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "errorDeviceCount"              = var.error_device_count
    "nonCompliantDeviceCount"       = var.non_compliant_device_count
    "notApplicableDeviceCount"      = var.not_applicable_device_count
    "@odata.type"                   = var.odata_type
    "platformType"                  = var.platform_type
    "remediatedDeviceCount"         = var.remediated_device_count
    "setting"                       = var.setting
    "settingName"                   = var.setting_name
    "unknownDeviceCount"            = var.unknown_device_count
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceCompliancePolicySettingStateSummaries"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
