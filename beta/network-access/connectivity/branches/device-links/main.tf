# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "bandwidthCapacityInMbps" = var.bandwidth_capacity_in_mbps
    "bgpConfiguration"        = (var.bgp_configuration == null ? null : { for key0, value0 in { "@odata.type" = var.bgp_configuration["odata_type"], "asn" = var.bgp_configuration["asn"], "ipAddress" = var.bgp_configuration["ipAddress"], "localIpAddress" = var.bgp_configuration["localIpAddress"], "peerIpAddress" = var.bgp_configuration["peerIpAddress"] } : key0 => value0 if value0 != null })
    "deviceVendor"            = var.device_vendor
    "ipAddress"               = var.ip_address
    "lastModifiedDateTime"    = var.last_modified_date_time
    "name"                    = var.name
    "@odata.type"             = var.odata_type
    "redundancyConfiguration" = (var.redundancy_configuration == null ? null : { for key0, value0 in { "@odata.type" = var.redundancy_configuration["odata_type"], "redundancyTier" = var.redundancy_configuration["redundancyTier"], "zoneLocalIpAddress" = var.redundancy_configuration["zoneLocalIpAddress"] } : key0 => value0 if value0 != null })
    "tunnelConfiguration"     = var.tunnel_configuration
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "networkAccess/connectivity/branches/${urlencode(var.branch_site_id)}/deviceLinks"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
