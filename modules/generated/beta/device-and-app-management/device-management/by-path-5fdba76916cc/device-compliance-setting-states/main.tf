# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "complianceGracePeriodExpirationDateTime" = var.compliance_grace_period_expiration_date_time
    "deviceId"                                = var.device_id
    "deviceModel"                             = var.device_model
    "deviceName"                              = var.device_name
    "@odata.type"                             = var.odata_type
    "platformType"                            = var.platform_type
    "setting"                                 = var.setting
    "settingName"                             = var.setting_name
    "state"                                   = var.state
    "userEmail"                               = var.user_email
    "userId"                                  = var.user_id
    "userName"                                = var.user_name
    "userPrincipalName"                       = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceCompliancePolicySettingStateSummaries/${urlencode(var.device_compliance_policy_setting_state_summary_id)}/deviceComplianceSettingStates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
