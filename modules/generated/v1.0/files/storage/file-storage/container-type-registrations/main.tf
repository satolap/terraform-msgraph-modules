# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "applicationPermissionGrants" = (var.application_permission_grants == null ? null : [for item0 in var.application_permission_grants : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appId" = item0["appId"], "applicationPermissions" = (item0["applicationPermissions"] == null ? null : [for item2 in item0["applicationPermissions"] : item2 if item2 != null]), "delegatedPermissions" = (item0["delegatedPermissions"] == null ? null : [for item2 in item0["delegatedPermissions"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "billingClassification"       = var.billing_classification
    "billingStatus"               = var.billing_status
    "@odata.type"                 = var.odata_type
    "settings"                    = (var.settings == null ? null : { for key0, value0 in { "@odata.type" = var.settings["odata_type"], "isDiscoverabilityEnabled" = var.settings["isDiscoverabilityEnabled"], "isItemVersioningEnabled" = var.settings["isItemVersioningEnabled"], "isSearchEnabled" = var.settings["isSearchEnabled"], "isSharingRestricted" = var.settings["isSharingRestricted"], "itemMajorVersionLimit" = var.settings["itemMajorVersionLimit"], "maxStoragePerContainerInBytes" = var.settings["maxStoragePerContainerInBytes"], "sharingCapability" = var.settings["sharingCapability"], "urlTemplate" = var.settings["urlTemplate"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "storage/fileStorage/containerTypeRegistrations"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
