# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appIdentifier"                   = var.app_identifier
    "applicationVersion"              = var.application_version
    "appliedPolicies"                 = (var.applied_policies == null ? null : [for item0 in var.applied_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "roleScopeTagIds" = (item0["roleScopeTagIds"] == null ? null : [for item2 in item0["roleScopeTagIds"] : item2 if item2 != null]), "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "azureADDeviceId"                 = var.azure_ad_device_id
    "createdDateTime"                 = var.created_date_time
    "deviceManufacturer"              = var.device_manufacturer
    "deviceModel"                     = var.device_model
    "deviceName"                      = var.device_name
    "deviceTag"                       = var.device_tag
    "deviceType"                      = var.device_type
    "flaggedReasons"                  = (var.flagged_reasons == null ? null : [for item0 in var.flagged_reasons : item0 if item0 != null])
    "version"                         = var.graph_version
    "intendedPolicies"                = (var.intended_policies == null ? null : [for item0 in var.intended_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "roleScopeTagIds" = (item0["roleScopeTagIds"] == null ? null : [for item2 in item0["roleScopeTagIds"] : item2 if item2 != null]), "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastSyncDateTime"                = var.last_sync_date_time
    "managedAppLogCollectionRequests" = (var.managed_app_log_collection_requests == null ? null : [for item0 in var.managed_app_log_collection_requests : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "userLogUploadConsent" = item0["userLogUploadConsent"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "managedDeviceId"                 = var.managed_device_id
    "managementSdkVersion"            = var.management_sdk_version
    "@odata.type"                     = var.odata_type
    "operations"                      = (var.operations == null ? null : [for item0 in var.operations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "state" = item0["state"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "platformVersion"                 = var.platform_version
    "userId"                          = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/managedAppRegistrations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
