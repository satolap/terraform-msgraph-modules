# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "billingClassification" = var.billingClassification
    "billingStatus"         = var.billingStatus
    "name"                  = var.name
    "@odata.type"           = var.odata_type
    "owningAppId"           = var.owningAppId
    "settings"              = (var.settings == null ? null : { for key0, value0 in { "@odata.type" = var.settings["odata_type"], "consumingTenantOverridables" = var.settings["consumingTenantOverridables"], "isDiscoverabilityEnabled" = var.settings["isDiscoverabilityEnabled"], "isItemVersioningEnabled" = var.settings["isItemVersioningEnabled"], "isOfficeRestricted" = var.settings["isOfficeRestricted"], "isSearchEnabled" = var.settings["isSearchEnabled"], "isSharingRestricted" = var.settings["isSharingRestricted"], "itemMajorVersionLimit" = var.settings["itemMajorVersionLimit"], "maxStoragePerContainerInBytes" = var.settings["maxStoragePerContainerInBytes"], "sharingCapability" = var.settings["sharingCapability"], "urlTemplate" = var.settings["urlTemplate"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "storage/fileStorage/containerTypes"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

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
