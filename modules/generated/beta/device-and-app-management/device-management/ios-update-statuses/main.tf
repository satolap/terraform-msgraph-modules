# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "complianceGracePeriodExpirationDateTime" = var.compliance_grace_period_expiration_date_time
    "deviceDisplayName"                       = var.device_display_name
    "deviceId"                                = var.device_id
    "deviceModel"                             = var.device_model
    "installStatus"                           = var.install_status
    "lastReportedDateTime"                    = var.last_reported_date_time
    "@odata.type"                             = var.odata_type
    "osVersion"                               = var.os_version
    "platform"                                = var.platform
    "status"                                  = var.status
    "userId"                                  = var.user_id
    "userName"                                = var.user_name
    "userPrincipalName"                       = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/iosUpdateStatuses"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
