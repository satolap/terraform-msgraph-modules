# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "billingClassification" = var.billing_classification
    "billingStatus"         = var.billing_status
    "name"                  = var.name
    "@odata.type"           = var.odata_type
    "owningAppId"           = var.owning_app_id
    "permissions"           = (var.permissions == null ? null : [for item0 in var.permissions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "expirationDateTime" = item0["expirationDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "settings"              = (var.settings == null ? null : { for key0, value0 in { "@odata.type" = var.settings["odata_type"], "consumingTenantOverridables" = var.settings["consumingTenantOverridables"], "isDiscoverabilityEnabled" = var.settings["isDiscoverabilityEnabled"], "isItemVersioningEnabled" = var.settings["isItemVersioningEnabled"], "isOfficeRestricted" = var.settings["isOfficeRestricted"], "isSearchEnabled" = var.settings["isSearchEnabled"], "isSharingRestricted" = var.settings["isSharingRestricted"], "itemMajorVersionLimit" = var.settings["itemMajorVersionLimit"], "maxStoragePerContainerInBytes" = var.settings["maxStoragePerContainerInBytes"], "sharingCapability" = var.settings["sharingCapability"], "urlTemplate" = var.settings["urlTemplate"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "storage/fileStorage/containerTypes"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
