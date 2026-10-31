# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"                     = var.odata_type
    "appIdentifier"                   = var.appIdentifier
    "applicationVersion"              = var.applicationVersion
    "appliedPolicies"                 = (var.appliedPolicies == null ? null : [for item0 in var.appliedPolicies : item0 if item0 != null])
    "azureADDeviceId"                 = var.azureADDeviceId
    "createdDateTime"                 = var.createdDateTime
    "deviceManufacturer"              = var.deviceManufacturer
    "deviceModel"                     = var.deviceModel
    "deviceName"                      = var.deviceName
    "deviceTag"                       = var.deviceTag
    "deviceType"                      = var.deviceType
    "flaggedReasons"                  = (var.flaggedReasons == null ? null : [for item0 in var.flaggedReasons : item0 if item0 != null])
    "version"                         = var.graph_version
    "intendedPolicies"                = (var.intendedPolicies == null ? null : [for item0 in var.intendedPolicies : item0 if item0 != null])
    "lastSyncDateTime"                = var.lastSyncDateTime
    "managedAppLogCollectionRequests" = (var.managedAppLogCollectionRequests == null ? null : [for item0 in var.managedAppLogCollectionRequests : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "userLogUploadConsent" = item0["userLogUploadConsent"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "managedDeviceId"                 = var.managedDeviceId
    "managementSdkVersion"            = var.managementSdkVersion
    "operations"                      = (var.operations == null ? null : [for item0 in var.operations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "state" = item0["state"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "platformVersion"                 = var.platformVersion
    "userId"                          = var.userId
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/managedAppRegistrations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["appliedPolicies", "intendedPolicies", "managedAppLogCollectionRequests", "operations"], name)])]))))] } : null

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
