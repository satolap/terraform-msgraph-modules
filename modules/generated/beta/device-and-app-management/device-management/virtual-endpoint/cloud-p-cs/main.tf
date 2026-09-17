# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "aadDeviceId"                = var.aad_device_id
    "connectivityResult"         = var.connectivity_result
    "diskEncryptionState"        = var.disk_encryption_state
    "displayName"                = var.display_name
    "gracePeriodEndDateTime"     = var.grace_period_end_date_time
    "imageDisplayName"           = var.image_display_name
    "lastLoginResult"            = var.last_login_result
    "lastModifiedDateTime"       = var.last_modified_date_time
    "lastRemoteActionResult"     = var.last_remote_action_result
    "managedDeviceId"            = var.managed_device_id
    "managedDeviceName"          = var.managed_device_name
    "@odata.type"                = var.odata_type
    "onPremisesConnectionName"   = var.on_premises_connection_name
    "osVersion"                  = var.os_version
    "partnerAgentInstallResults" = (var.partner_agent_install_results == null ? null : [for item0 in var.partner_agent_install_results : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "errorMessage" = item0["errorMessage"], "isThirdPartyPartner" = item0["isThirdPartyPartner"], "retriable" = item0["retriable"] } : key1 => value1 if value1 != null }) if item0 != null])
    "powerState"                 = var.power_state
    "provisionedDateTime"        = var.provisioned_date_time
    "provisioningPolicyId"       = var.provisioning_policy_id
    "provisioningPolicyName"     = var.provisioning_policy_name
    "provisioningType"           = var.provisioning_type
    "servicePlanId"              = var.service_plan_id
    "servicePlanName"            = var.service_plan_name
    "servicePlanType"            = var.service_plan_type
    "sharedDeviceDetail"         = var.shared_device_detail
    "status"                     = var.status
    "statusDetail"               = var.status_detail
    "statusDetails"              = var.status_details
    "userAccountType"            = var.user_account_type
    "userExperienceType"         = var.user_experience_type
    "userPrincipalName"          = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/cloudPCs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
