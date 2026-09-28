# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "connectivityConfiguration" = var.connectivity_configuration
    "deviceLinks"               = (var.device_links == null ? null : [for item0 in var.device_links : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "bandwidthCapacityInMbps" = item0["bandwidthCapacityInMbps"], "bgpConfiguration" = (item0["bgpConfiguration"] == null ? null : { for key2, value2 in { "@odata.type" = item0["bgpConfiguration"]["odata_type"], "asn" = item0["bgpConfiguration"]["asn"], "ipAddress" = item0["bgpConfiguration"]["ipAddress"], "localIpAddress" = item0["bgpConfiguration"]["localIpAddress"], "peerIpAddress" = item0["bgpConfiguration"]["peerIpAddress"] } : key2 => value2 if value2 != null }), "deviceVendor" = item0["deviceVendor"], "ipAddress" = item0["ipAddress"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "name" = item0["name"], "redundancyConfiguration" = (item0["redundancyConfiguration"] == null ? null : { for key2, value2 in { "@odata.type" = item0["redundancyConfiguration"]["odata_type"], "redundancyTier" = item0["redundancyConfiguration"]["redundancyTier"], "zoneLocalIpAddress" = item0["redundancyConfiguration"]["zoneLocalIpAddress"] } : key2 => value2 if value2 != null }), "tunnelConfiguration" = item0["tunnelConfiguration"] } : key1 => value1 if value1 != null }) if item0 != null])
    "forwardingProfiles"        = (var.forwarding_profiles == null ? null : [for item0 in var.forwarding_profiles : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "associations" = (item0["associations"] == null ? null : [for item2 in item0["associations"] : item2 if item2 != null]), "description" = item0["description"], "isCustomProfile" = item0["isCustomProfile"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "name" = item0["name"], "policies" = (item0["policies"] == null ? null : [for item2 in item0["policies"] : item2 if item2 != null]), "priority" = item0["priority"], "servicePrincipal" = item0["servicePrincipal"], "state" = item0["state"], "trafficForwardingType" = item0["trafficForwardingType"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "version"                   = var.graph_version
    "lastModifiedDateTime"      = var.last_modified_date_time
    "name"                      = var.name
    "@odata.type"               = var.odata_type
    "region"                    = var.region
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "networkAccess/connectivity/remoteNetworks"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
