# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "billingClassification" = var.billing_classification
    "billingStatus"         = var.billing_status
    "name"                  = var.name
    "@odata.type"           = var.odata_type
    "owningAppId"           = var.owning_app_id
    "settings"              = (var.settings == null ? null : { for key0, value0 in { "@odata.type" = var.settings["odata_type"], "consumingTenantOverridables" = var.settings["consumingTenantOverridables"], "isDiscoverabilityEnabled" = var.settings["isDiscoverabilityEnabled"], "isItemVersioningEnabled" = var.settings["isItemVersioningEnabled"], "isSearchEnabled" = var.settings["isSearchEnabled"], "isSharingRestricted" = var.settings["isSharingRestricted"], "itemMajorVersionLimit" = var.settings["itemMajorVersionLimit"], "maxStoragePerContainerInBytes" = var.settings["maxStoragePerContainerInBytes"], "sharingCapability" = var.settings["sharingCapability"], "urlTemplate" = var.settings["urlTemplate"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "storage/fileStorage/containerTypes"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
