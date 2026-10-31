# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedInboundDataTransferSourceApps"       = var.allowedInboundDataTransferSourceApps
    "allowedInboundDataTransferSources"          = var.allowedInboundDataTransferSources
    "allowedOutboundClipboardSharingLevel"       = var.allowedOutboundClipboardSharingLevel
    "allowedOutboundDataTransferDestinationApps" = var.allowedOutboundDataTransferDestinationApps
    "allowedOutboundDataTransferDestinations"    = var.allowedOutboundDataTransferDestinations
    "appActionIfUnableToAuthenticateUser"        = var.appActionIfUnableToAuthenticateUser
    "apps"                                       = (var.apps == null ? null : [for item0 in var.apps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "mobileAppIdentifier" = item0["mobileAppIdentifier"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignments"                                = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "source" = item0["source"], "sourceId" = item0["sourceId"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"                            = var.createdDateTime
    "deployedAppCount"                           = var.deployedAppCount
    "deploymentSummary"                          = var.deploymentSummary
    "description"                                = var.description
    "displayName"                                = var.displayName
    "version"                                    = var.graph_version
    "isAssigned"                                 = var.isAssigned
    "lastModifiedDateTime"                       = var.lastModifiedDateTime
    "maximumAllowedDeviceThreatLevel"            = var.maximumAllowedDeviceThreatLevel
    "maximumRequiredOsVersion"                   = var.maximumRequiredOsVersion
    "maximumWarningOsVersion"                    = var.maximumWarningOsVersion
    "maximumWipeOsVersion"                       = var.maximumWipeOsVersion
    "minimumRequiredAppVersion"                  = var.minimumRequiredAppVersion
    "minimumRequiredOsVersion"                   = var.minimumRequiredOsVersion
    "minimumRequiredSdkVersion"                  = var.minimumRequiredSdkVersion
    "minimumWarningAppVersion"                   = var.minimumWarningAppVersion
    "minimumWarningOsVersion"                    = var.minimumWarningOsVersion
    "minimumWipeAppVersion"                      = var.minimumWipeAppVersion
    "minimumWipeOsVersion"                       = var.minimumWipeOsVersion
    "minimumWipeSdkVersion"                      = var.minimumWipeSdkVersion
    "mobileThreatDefenseRemediationAction"       = var.mobileThreatDefenseRemediationAction
    "@odata.type"                                = var.odata_type
    "periodOfflineBeforeAccessCheck"             = var.periodOfflineBeforeAccessCheck
    "periodOfflineBeforeWipeIsEnforced"          = var.periodOfflineBeforeWipeIsEnforced
    "printBlocked"                               = var.printBlocked
    "roleScopeTagIds"                            = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/windowsManagedAppProtections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["apps", "assignments", "deploymentSummary"], name)])]))))] } : null

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
