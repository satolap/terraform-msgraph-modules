# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "bandwidthCapacityInMbps" = var.bandwidthCapacityInMbps
    "bgpConfiguration"        = (var.bgpConfiguration == null ? null : { for key0, value0 in { "@odata.type" = var.bgpConfiguration["odata_type"], "asn" = var.bgpConfiguration["asn"], "ipAddress" = var.bgpConfiguration["ipAddress"], "localIpAddress" = var.bgpConfiguration["localIpAddress"], "peerIpAddress" = var.bgpConfiguration["peerIpAddress"] } : key0 => value0 if value0 != null })
    "deviceVendor"            = var.deviceVendor
    "ipAddress"               = var.ipAddress
    "lastModifiedDateTime"    = var.lastModifiedDateTime
    "name"                    = var.name
    "@odata.type"             = var.odata_type
    "redundancyConfiguration" = (var.redundancyConfiguration == null ? null : { for key0, value0 in { "@odata.type" = var.redundancyConfiguration["odata_type"], "redundancyTier" = var.redundancyConfiguration["redundancyTier"], "zoneLocalIpAddress" = var.redundancyConfiguration["zoneLocalIpAddress"] } : key0 => value0 if value0 != null })
    "tunnelConfiguration"     = var.tunnelConfiguration
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "networkAccess/connectivity/branches/${urlencode(var.branchSite-id)}/deviceLinks"
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
