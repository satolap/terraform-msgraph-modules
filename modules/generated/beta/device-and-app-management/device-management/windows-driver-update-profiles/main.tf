# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "approvalType"             = var.approval_type
    "assignments"              = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = (item0["target"] == null ? null : { for key2, value2 in { "@odata.type" = item0["target"]["odata_type"], "deviceAndAppManagementAssignmentFilterId" = item0["target"]["deviceAndAppManagementAssignmentFilterId"], "deviceAndAppManagementAssignmentFilterType" = item0["target"]["deviceAndAppManagementAssignmentFilterType"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"          = var.created_date_time
    "deploymentDeferralInDays" = var.deployment_deferral_in_days
    "description"              = var.description
    "deviceReporting"          = var.device_reporting
    "displayName"              = var.display_name
    "driverInventories"        = (var.driver_inventories == null ? null : [for item0 in var.driver_inventories : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "applicableDeviceCount" = item0["applicableDeviceCount"], "approvalStatus" = item0["approvalStatus"], "category" = item0["category"], "deployDateTime" = item0["deployDateTime"], "driverClass" = item0["driverClass"], "manufacturer" = item0["manufacturer"], "name" = item0["name"], "releaseDateTime" = item0["releaseDateTime"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "inventorySyncStatus"      = var.inventory_sync_status
    "lastModifiedDateTime"     = var.last_modified_date_time
    "newUpdates"               = var.new_updates
    "@odata.type"              = var.odata_type
    "roleScopeTagIds"          = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/windowsDriverUpdateProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
