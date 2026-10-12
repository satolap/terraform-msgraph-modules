# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"                     = var.description
    "displayName"                     = var.display_name
    "internalNetworkProbeUrl"         = var.internal_network_probe_url
    "microsoftTunnelConfiguration"    = var.microsoft_tunnel_configuration
    "microsoftTunnelServers"          = (var.microsoft_tunnel_servers == null ? null : [for item0 in var.microsoft_tunnel_servers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "tunnelServerHealthStatus" = item0["tunnelServerHealthStatus"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                     = var.odata_type
    "publicAddress"                   = var.public_address
    "roleScopeTagIds"                 = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "upgradeAutomatically"            = var.upgrade_automatically
    "upgradeAvailable"                = var.upgrade_available
    "upgradeWindowEndTime"            = var.upgrade_window_end_time
    "upgradeWindowStartTime"          = var.upgrade_window_start_time
    "upgradeWindowUtcOffsetInMinutes" = var.upgrade_window_utc_offset_in_minutes
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/microsoftTunnelSites"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
