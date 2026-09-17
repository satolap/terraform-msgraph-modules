# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "addressableUserName"                       = var.addressable_user_name
    "azureActiveDirectoryDeviceId"              = var.azure_active_directory_device_id
    "azureAdDeviceId"                           = var.azure_ad_device_id
    "deploymentProfile"                         = var.deployment_profile
    "deploymentProfileAssignedDateTime"         = var.deployment_profile_assigned_date_time
    "deploymentProfileAssignmentDetailedStatus" = var.deployment_profile_assignment_detailed_status
    "deploymentProfileAssignmentStatus"         = var.deployment_profile_assignment_status
    "deviceAccountPassword"                     = var.device_account_password
    "deviceAccountUpn"                          = var.device_account_upn
    "deviceFriendlyName"                        = var.device_friendly_name
    "displayName"                               = var.display_name
    "enrollmentState"                           = var.enrollment_state
    "groupTag"                                  = var.group_tag
    "intendedDeploymentProfile"                 = var.intended_deployment_profile
    "lastContactedDateTime"                     = var.last_contacted_date_time
    "managedDeviceId"                           = var.managed_device_id
    "manufacturer"                              = var.manufacturer
    "model"                                     = var.model
    "@odata.type"                               = var.odata_type
    "productKey"                                = var.product_key
    "purchaseOrderIdentifier"                   = var.purchase_order_identifier
    "remediationState"                          = var.remediation_state
    "remediationStateLastModifiedDateTime"      = var.remediation_state_last_modified_date_time
    "resourceName"                              = var.resource_name
    "serialNumber"                              = var.serial_number
    "skuNumber"                                 = var.sku_number
    "systemFamily"                              = var.system_family
    "userPrincipalName"                         = var.user_principal_name
    "userlessEnrollmentStatus"                  = var.userless_enrollment_status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/windowsAutopilotDeploymentProfiles/${urlencode(var.windows_autopilot_deployment_profile_id)}/assignedDevices"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
