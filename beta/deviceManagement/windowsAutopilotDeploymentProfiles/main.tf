# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"                    = var.odata_type
    "assignedDevices"                = (var.assignedDevices == null ? null : [for item0 in var.assignedDevices : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "addressableUserName" = item0["addressableUserName"], "azureActiveDirectoryDeviceId" = item0["azureActiveDirectoryDeviceId"], "azureAdDeviceId" = item0["azureAdDeviceId"], "deploymentProfile" = item0["deploymentProfile"], "deploymentProfileAssignedDateTime" = item0["deploymentProfileAssignedDateTime"], "deploymentProfileAssignmentDetailedStatus" = item0["deploymentProfileAssignmentDetailedStatus"], "deploymentProfileAssignmentStatus" = item0["deploymentProfileAssignmentStatus"], "deviceAccountPassword" = item0["deviceAccountPassword"], "deviceAccountUpn" = item0["deviceAccountUpn"], "deviceFriendlyName" = item0["deviceFriendlyName"], "displayName" = item0["displayName"], "enrollmentState" = item0["enrollmentState"], "groupTag" = item0["groupTag"], "intendedDeploymentProfile" = item0["intendedDeploymentProfile"], "lastContactedDateTime" = item0["lastContactedDateTime"], "managedDeviceId" = item0["managedDeviceId"], "manufacturer" = item0["manufacturer"], "model" = item0["model"], "productKey" = item0["productKey"], "purchaseOrderIdentifier" = item0["purchaseOrderIdentifier"], "remediationState" = item0["remediationState"], "remediationStateLastModifiedDateTime" = item0["remediationStateLastModifiedDateTime"], "resourceName" = item0["resourceName"], "serialNumber" = item0["serialNumber"], "skuNumber" = item0["skuNumber"], "systemFamily" = item0["systemFamily"], "userPrincipalName" = item0["userPrincipalName"], "userlessEnrollmentStatus" = item0["userlessEnrollmentStatus"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignments"                    = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "source" = item0["source"], "sourceId" = item0["sourceId"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                    = var.description
    "deviceNameTemplate"             = var.deviceNameTemplate
    "deviceType"                     = var.deviceType
    "displayName"                    = var.displayName
    "enrollmentStatusScreenSettings" = (var.enrollmentStatusScreenSettings == null ? null : { for key0, value0 in { "@odata.type" = var.enrollmentStatusScreenSettings["odata_type"], "allowDeviceUseBeforeProfileAndAppInstallComplete" = var.enrollmentStatusScreenSettings["allowDeviceUseBeforeProfileAndAppInstallComplete"], "allowDeviceUseOnInstallFailure" = var.enrollmentStatusScreenSettings["allowDeviceUseOnInstallFailure"], "allowLogCollectionOnInstallFailure" = var.enrollmentStatusScreenSettings["allowLogCollectionOnInstallFailure"], "blockDeviceSetupRetryByUser" = var.enrollmentStatusScreenSettings["blockDeviceSetupRetryByUser"], "customErrorMessage" = var.enrollmentStatusScreenSettings["customErrorMessage"], "hideInstallationProgress" = var.enrollmentStatusScreenSettings["hideInstallationProgress"], "installProgressTimeoutInMinutes" = var.enrollmentStatusScreenSettings["installProgressTimeoutInMinutes"] } : key0 => value0 if value0 != null })
    "hardwareHashExtractionEnabled"  = var.hardwareHashExtractionEnabled
    "locale"                         = var.locale
    "managementServiceAppId"         = var.managementServiceAppId
    "outOfBoxExperienceSetting"      = (var.outOfBoxExperienceSetting == null ? null : { for key0, value0 in { "@odata.type" = var.outOfBoxExperienceSetting["odata_type"], "deviceUsageType" = var.outOfBoxExperienceSetting["deviceUsageType"], "escapeLinkHidden" = var.outOfBoxExperienceSetting["escapeLinkHidden"], "eulaHidden" = var.outOfBoxExperienceSetting["eulaHidden"], "keyboardSelectionPageSkipped" = var.outOfBoxExperienceSetting["keyboardSelectionPageSkipped"], "privacySettingsHidden" = var.outOfBoxExperienceSetting["privacySettingsHidden"], "userType" = var.outOfBoxExperienceSetting["userType"] } : key0 => value0 if value0 != null })
    "preprovisioningAllowed"         = var.preprovisioningAllowed
    "roleScopeTagIds"                = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/windowsAutopilotDeploymentProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignedDevices", "assignments"], name)])]))))] } : null

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
