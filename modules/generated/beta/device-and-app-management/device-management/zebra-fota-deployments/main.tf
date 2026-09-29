# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deploymentSettings" = (var.deployment_settings == null ? null : { for key0, value0 in { "@odata.type" = var.deployment_settings["odata_type"], "batteryRuleMinimumBatteryLevelPercentage" = var.deployment_settings["batteryRuleMinimumBatteryLevelPercentage"], "batteryRuleRequireCharger" = var.deployment_settings["batteryRuleRequireCharger"], "deviceModel" = var.deployment_settings["deviceModel"], "downloadRuleNetworkType" = var.deployment_settings["downloadRuleNetworkType"], "downloadRuleStartDateTime" = var.deployment_settings["downloadRuleStartDateTime"], "firmwareTargetArtifactDescription" = var.deployment_settings["firmwareTargetArtifactDescription"], "firmwareTargetBoardSupportPackageVersion" = var.deployment_settings["firmwareTargetBoardSupportPackageVersion"], "firmwareTargetOsVersion" = var.deployment_settings["firmwareTargetOsVersion"], "firmwareTargetPatch" = var.deployment_settings["firmwareTargetPatch"], "installRuleStartDateTime" = var.deployment_settings["installRuleStartDateTime"], "installRuleWindowEndTime" = var.deployment_settings["installRuleWindowEndTime"], "installRuleWindowStartTime" = var.deployment_settings["installRuleWindowStartTime"], "scheduleDurationInDays" = var.deployment_settings["scheduleDurationInDays"], "scheduleMode" = var.deployment_settings["scheduleMode"], "timeZoneOffsetInMinutes" = var.deployment_settings["timeZoneOffsetInMinutes"], "updateType" = var.deployment_settings["updateType"] } : key0 => value0 if value0 != null })
    "deploymentStatus"   = (var.deployment_status == null ? null : { for key0, value0 in { "@odata.type" = var.deployment_status["odata_type"], "cancelRequested" = var.deployment_status["cancelRequested"], "completeOrCanceledDateTime" = var.deployment_status["completeOrCanceledDateTime"], "errorCode" = var.deployment_status["errorCode"], "lastUpdatedDateTime" = var.deployment_status["lastUpdatedDateTime"], "state" = var.deployment_status["state"], "totalAwaitingInstall" = var.deployment_status["totalAwaitingInstall"], "totalCanceled" = var.deployment_status["totalCanceled"], "totalCreated" = var.deployment_status["totalCreated"], "totalDevices" = var.deployment_status["totalDevices"], "totalDownloading" = var.deployment_status["totalDownloading"], "totalFailedDownload" = var.deployment_status["totalFailedDownload"], "totalFailedInstall" = var.deployment_status["totalFailedInstall"], "totalScheduled" = var.deployment_status["totalScheduled"], "totalSucceededInstall" = var.deployment_status["totalSucceededInstall"], "totalUnknown" = var.deployment_status["totalUnknown"] } : key0 => value0 if value0 != null })
    "description"        = var.description
    "displayName"        = var.display_name
    "@odata.type"        = var.odata_type
    "roleScopeTagIds"    = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/zebraFotaDeployments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
