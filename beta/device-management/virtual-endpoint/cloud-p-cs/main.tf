# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "aadDeviceId"                = var.aad_device_id
    "connectivityResult"         = (var.connectivity_result == null ? null : { for key0, value0 in { "@odata.type" = var.connectivity_result["odata_type"], "failedHealthCheckItems" = (var.connectivity_result["failedHealthCheckItems"] == null ? null : [for item1 in var.connectivity_result["failedHealthCheckItems"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "additionalDetails" = item1["additionalDetails"], "displayName" = item1["displayName"], "lastHealthCheckDateTime" = item1["lastHealthCheckDateTime"], "result" = item1["result"] } : key2 => value2 if value2 != null }) if item1 != null]), "lastModifiedDateTime" = var.connectivity_result["lastModifiedDateTime"], "status" = var.connectivity_result["status"] } : key0 => value0 if value0 != null })
    "diskEncryptionState"        = var.disk_encryption_state
    "displayName"                = var.display_name
    "gracePeriodEndDateTime"     = var.grace_period_end_date_time
    "imageDisplayName"           = var.image_display_name
    "lastLoginResult"            = (var.last_login_result == null ? null : { for key0, value0 in { "@odata.type" = var.last_login_result["odata_type"] } : key0 => value0 if value0 != null })
    "lastModifiedDateTime"       = var.last_modified_date_time
    "lastRemoteActionResult"     = (var.last_remote_action_result == null ? null : { for key0, value0 in { "@odata.type" = var.last_remote_action_result["odata_type"], "actionName" = var.last_remote_action_result["actionName"], "lastUpdatedDateTime" = var.last_remote_action_result["lastUpdatedDateTime"], "startDateTime" = var.last_remote_action_result["startDateTime"], "statusDetail" = (var.last_remote_action_result["statusDetail"] == null ? null : { for key1, value1 in { "@odata.type" = var.last_remote_action_result["statusDetail"]["odata_type"], "additionalInformation" = (var.last_remote_action_result["statusDetail"]["additionalInformation"] == null ? null : [for item2 in var.last_remote_action_result["statusDetail"]["additionalInformation"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "name" = item2["name"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "code" = var.last_remote_action_result["statusDetail"]["code"], "message" = var.last_remote_action_result["statusDetail"]["message"] } : key1 => value1 if value1 != null }), "statusDetails" = (var.last_remote_action_result["statusDetails"] == null ? null : { for key1, value1 in { "@odata.type" = var.last_remote_action_result["statusDetails"]["odata_type"], "additionalInformation" = (var.last_remote_action_result["statusDetails"]["additionalInformation"] == null ? null : [for item2 in var.last_remote_action_result["statusDetails"]["additionalInformation"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "name" = item2["name"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "code" = var.last_remote_action_result["statusDetails"]["code"], "message" = var.last_remote_action_result["statusDetails"]["message"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
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
    "sharedDeviceDetail"         = (var.shared_device_detail == null ? null : { for key0, value0 in { "@odata.type" = var.shared_device_detail["odata_type"], "assignedToUserPrincipalName" = var.shared_device_detail["assignedToUserPrincipalName"], "sessionStartDateTime" = var.shared_device_detail["sessionStartDateTime"] } : key0 => value0 if value0 != null })
    "status"                     = var.status
    "statusDetail"               = (var.status_detail == null ? null : { for key0, value0 in { "@odata.type" = var.status_detail["odata_type"], "additionalInformation" = (var.status_detail["additionalInformation"] == null ? null : [for item1 in var.status_detail["additionalInformation"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "name" = item1["name"], "value" = item1["value"] } : key2 => value2 if value2 != null }) if item1 != null]), "code" = var.status_detail["code"], "message" = var.status_detail["message"] } : key0 => value0 if value0 != null })
    "statusDetails"              = (var.status_details == null ? null : { for key0, value0 in { "@odata.type" = var.status_details["odata_type"], "additionalInformation" = (var.status_details["additionalInformation"] == null ? null : [for item1 in var.status_details["additionalInformation"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "name" = item1["name"], "value" = item1["value"] } : key2 => value2 if value2 != null }) if item1 != null]), "code" = var.status_details["code"], "message" = var.status_details["message"] } : key0 => value0 if value0 != null })
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
