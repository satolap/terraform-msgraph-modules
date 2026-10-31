# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "approvalType"             = var.approvalType
    "assignments"              = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"          = var.createdDateTime
    "deploymentDeferralInDays" = var.deploymentDeferralInDays
    "description"              = var.description
    "deviceReporting"          = var.deviceReporting
    "displayName"              = var.displayName
    "driverInventories"        = (var.driverInventories == null ? null : [for item0 in var.driverInventories : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "applicableDeviceCount" = item0["applicableDeviceCount"], "approvalStatus" = item0["approvalStatus"], "category" = item0["category"], "deployDateTime" = item0["deployDateTime"], "driverClass" = item0["driverClass"], "manufacturer" = item0["manufacturer"], "name" = item0["name"], "releaseDateTime" = item0["releaseDateTime"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "inventorySyncStatus"      = (var.inventorySyncStatus == null ? null : { for key0, value0 in { "@odata.type" = var.inventorySyncStatus["odata_type"], "driverInventorySyncState" = var.inventorySyncStatus["driverInventorySyncState"], "lastSuccessfulSyncDateTime" = var.inventorySyncStatus["lastSuccessfulSyncDateTime"] } : key0 => value0 if value0 != null })
    "lastModifiedDateTime"     = var.lastModifiedDateTime
    "newUpdates"               = var.newUpdates
    "@odata.type"              = var.odata_type
    "roleScopeTagIds"          = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/windowsDriverUpdateProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments", "driverInventories"], name)])]))))] } : null

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
