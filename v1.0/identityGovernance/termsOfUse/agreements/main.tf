# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"                       = var.displayName
    "file"                              = var.file
    "files"                             = (var.files == null ? null : [for item0 in var.files : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "isMajorVersion" = item0["isMajorVersion"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isPerDeviceAcceptanceRequired"     = var.isPerDeviceAcceptanceRequired
    "isViewingBeforeAcceptanceRequired" = var.isViewingBeforeAcceptanceRequired
    "@odata.type"                       = var.odata_type
    "termsExpiration"                   = (var.termsExpiration == null ? null : { for key0, value0 in { "@odata.type" = var.termsExpiration["odata_type"], "frequency" = var.termsExpiration["frequency"], "startDateTime" = var.termsExpiration["startDateTime"] } : key0 => value0 if value0 != null })
    "userReacceptRequiredFrequency"     = var.userReacceptRequiredFrequency
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/termsOfUse/agreements"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["file", "files"], name)])]))))] } : null

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
