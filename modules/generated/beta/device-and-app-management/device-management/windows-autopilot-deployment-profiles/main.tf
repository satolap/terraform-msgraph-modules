# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignedDevices"                = (var.assigned_devices == null ? null : [for item0 in var.assigned_devices : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "addressableUserName" = item0["addressableUserName"], "azureActiveDirectoryDeviceId" = item0["azureActiveDirectoryDeviceId"], "azureAdDeviceId" = item0["azureAdDeviceId"], "deploymentProfile" = item0["deploymentProfile"], "deploymentProfileAssignedDateTime" = item0["deploymentProfileAssignedDateTime"], "deploymentProfileAssignmentDetailedStatus" = item0["deploymentProfileAssignmentDetailedStatus"], "deploymentProfileAssignmentStatus" = item0["deploymentProfileAssignmentStatus"], "deviceAccountPassword" = item0["deviceAccountPassword"], "deviceAccountUpn" = item0["deviceAccountUpn"], "deviceFriendlyName" = item0["deviceFriendlyName"], "displayName" = item0["displayName"], "enrollmentState" = item0["enrollmentState"], "groupTag" = item0["groupTag"], "intendedDeploymentProfile" = item0["intendedDeploymentProfile"], "lastContactedDateTime" = item0["lastContactedDateTime"], "managedDeviceId" = item0["managedDeviceId"], "manufacturer" = item0["manufacturer"], "model" = item0["model"], "productKey" = item0["productKey"], "purchaseOrderIdentifier" = item0["purchaseOrderIdentifier"], "remediationState" = item0["remediationState"], "remediationStateLastModifiedDateTime" = item0["remediationStateLastModifiedDateTime"], "resourceName" = item0["resourceName"], "serialNumber" = item0["serialNumber"], "skuNumber" = item0["skuNumber"], "systemFamily" = item0["systemFamily"], "userPrincipalName" = item0["userPrincipalName"], "userlessEnrollmentStatus" = item0["userlessEnrollmentStatus"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignments"                    = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "source" = item0["source"], "sourceId" = item0["sourceId"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                    = var.description
    "deviceNameTemplate"             = var.device_name_template
    "deviceType"                     = var.device_type
    "displayName"                    = var.display_name
    "enrollmentStatusScreenSettings" = var.enrollment_status_screen_settings
    "hardwareHashExtractionEnabled"  = var.hardware_hash_extraction_enabled
    "locale"                         = var.locale
    "managementServiceAppId"         = var.management_service_app_id
    "@odata.type"                    = var.odata_type
    "outOfBoxExperienceSetting"      = var.out_of_box_experience_setting
    "preprovisioningAllowed"         = var.preprovisioning_allowed
    "roleScopeTagIds"                = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/windowsAutopilotDeploymentProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
