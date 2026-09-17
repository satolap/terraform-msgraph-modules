# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appIdentifier"        = var.app_identifier
    "applicationVersion"   = var.application_version
    "appliedPolicies"      = (var.applied_policies == null ? null : [for item0 in var.applied_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"      = var.created_date_time
    "deviceName"           = var.device_name
    "deviceTag"            = var.device_tag
    "deviceType"           = var.device_type
    "flaggedReasons"       = (var.flagged_reasons == null ? null : [for item0 in var.flagged_reasons : item0 if item0 != null])
    "version"              = var.graph_version
    "intendedPolicies"     = (var.intended_policies == null ? null : [for item0 in var.intended_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastSyncDateTime"     = var.last_sync_date_time
    "managementSdkVersion" = var.management_sdk_version
    "@odata.type"          = var.odata_type
    "operations"           = (var.operations == null ? null : [for item0 in var.operations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "state" = item0["state"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "platformVersion"      = var.platform_version
    "userId"               = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/managedAppRegistrations"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
