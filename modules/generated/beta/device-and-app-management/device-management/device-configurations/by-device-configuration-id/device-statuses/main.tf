# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "complianceGracePeriodExpirationDateTime" = var.compliance_grace_period_expiration_date_time
    "deviceDisplayName"                       = var.device_display_name
    "deviceModel"                             = var.device_model
    "lastReportedDateTime"                    = var.last_reported_date_time
    "@odata.type"                             = var.odata_type
    "platform"                                = var.platform
    "status"                                  = var.status
    "userName"                                = var.user_name
    "userPrincipalName"                       = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/deviceConfigurations/${urlencode(var.device_configuration_id)}/deviceStatuses"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
