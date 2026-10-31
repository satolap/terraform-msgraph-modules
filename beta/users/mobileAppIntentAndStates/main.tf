# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "managedDeviceIdentifier" = var.managedDeviceIdentifier
    "mobileAppList"           = (var.mobileAppList == null ? null : [for item0 in var.mobileAppList : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "applicationId" = item0["applicationId"], "displayName" = item0["displayName"], "displayVersion" = item0["displayVersion"], "installState" = item0["installState"], "mobileAppIntent" = item0["mobileAppIntent"], "supportedDeviceTypes" = (item0["supportedDeviceTypes"] == null ? null : [for item2 in item0["supportedDeviceTypes"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "maximumOperatingSystemVersion" = item2["maximumOperatingSystemVersion"], "minimumOperatingSystemVersion" = item2["minimumOperatingSystemVersion"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"             = var.odata_type
    "userId"                  = var.userId
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user-id)}/mobileAppIntentAndStates"
  api_version             = "beta"
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
