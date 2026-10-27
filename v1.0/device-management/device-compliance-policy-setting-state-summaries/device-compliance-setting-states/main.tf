# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "complianceGracePeriodExpirationDateTime" = var.compliance_grace_period_expiration_date_time
    "deviceId"                                = var.device_id
    "deviceModel"                             = var.device_model
    "deviceName"                              = var.device_name
    "@odata.type"                             = var.odata_type
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

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceCompliancePolicySettingStateSummaries/${urlencode(var.device_compliance_policy_setting_state_summary_id)}/deviceComplianceSettingStates"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
