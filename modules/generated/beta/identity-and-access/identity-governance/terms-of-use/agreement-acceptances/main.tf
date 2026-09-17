# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "agreementFileId"    = var.agreement_file_id
    "agreementId"        = var.agreement_id
    "deviceDisplayName"  = var.device_display_name
    "deviceId"           = var.device_id
    "deviceOSType"       = var.device_os_type
    "deviceOSVersion"    = var.device_os_version
    "expirationDateTime" = var.expiration_date_time
    "@odata.type"        = var.odata_type
    "recordedDateTime"   = var.recorded_date_time
    "state"              = var.state
    "userDisplayName"    = var.user_display_name
    "userEmail"          = var.user_email
    "userId"             = var.user_id
    "userPrincipalName"  = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/termsOfUse/agreementAcceptances"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
