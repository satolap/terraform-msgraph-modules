# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deploymentStatus"  = var.deployment_status
    "deviceId"          = var.device_id
    "deviceName"        = var.device_name
    "lastSyncDateTime"  = var.last_sync_date_time
    "@odata.type"       = var.odata_type
    "osDescription"     = var.os_description
    "osVersion"         = var.os_version
    "policy"            = var.policy
    "policyVersion"     = var.policy_version
    "userName"          = var.user_name
    "userPrincipalName" = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/wdacSupplementalPolicies/${urlencode(var.windows_defender_application_control_supplemental_policy_id)}/deviceStatuses"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
