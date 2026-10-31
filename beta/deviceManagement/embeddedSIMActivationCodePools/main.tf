# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activationCodeCount" = var.activationCodeCount
    "activationCodes"     = (var.activationCodes == null ? null : [for item0 in var.activationCodes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "integratedCircuitCardIdentifier" = item0["integratedCircuitCardIdentifier"], "matchingIdentifier" = item0["matchingIdentifier"], "smdpPlusServerAddress" = item0["smdpPlusServerAddress"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignments"         = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"     = var.createdDateTime
    "deviceStates"        = (var.deviceStates == null ? null : [for item0 in var.deviceStates : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "deviceName" = item0["deviceName"], "lastSyncDateTime" = item0["lastSyncDateTime"], "modifiedDateTime" = item0["modifiedDateTime"], "state" = item0["state"], "stateDetails" = item0["stateDetails"], "universalIntegratedCircuitCardIdentifier" = item0["universalIntegratedCircuitCardIdentifier"], "userName" = item0["userName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"         = var.displayName
    "modifiedDateTime"    = var.modifiedDateTime
    "@odata.type"         = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/embeddedSIMActivationCodePools"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments", "deviceStates"], name)])]))))] } : null

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
