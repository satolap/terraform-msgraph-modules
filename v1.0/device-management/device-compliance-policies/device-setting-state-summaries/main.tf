# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "compliantDeviceCount"     = var.compliant_device_count
    "conflictDeviceCount"      = var.conflict_device_count
    "errorDeviceCount"         = var.error_device_count
    "instancePath"             = var.instance_path
    "nonCompliantDeviceCount"  = var.non_compliant_device_count
    "notApplicableDeviceCount" = var.not_applicable_device_count
    "@odata.type"              = var.odata_type
    "remediatedDeviceCount"    = var.remediated_device_count
    "settingName"              = var.setting_name
    "unknownDeviceCount"       = var.unknown_device_count
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceCompliancePolicies/${urlencode(var.device_compliance_policy_id)}/deviceSettingStateSummaries"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
