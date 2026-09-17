# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "advancedSettings"      = (var.advanced_settings == null ? null : [for item0 in var.advanced_settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "defaultDomainSuffix"   = var.default_domain_suffix
    "description"           = var.description
    "disableUdpConnections" = var.disable_udp_connections
    "displayName"           = var.display_name
    "dnsServers"            = (var.dns_servers == null ? null : [for item0 in var.dns_servers : item0 if item0 != null])
    "ipv6Network"           = var.ipv6_network
    "lastUpdateDateTime"    = var.last_update_date_time
    "listenPort"            = var.listen_port
    "network"               = var.network
    "@odata.type"           = var.odata_type
    "roleScopeTagIds"       = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "routeExcludes"         = (var.route_excludes == null ? null : [for item0 in var.route_excludes : item0 if item0 != null])
    "routeIncludes"         = (var.route_includes == null ? null : [for item0 in var.route_includes : item0 if item0 != null])
    "routesExclude"         = (var.routes_exclude == null ? null : [for item0 in var.routes_exclude : item0 if item0 != null])
    "routesInclude"         = (var.routes_include == null ? null : [for item0 in var.routes_include : item0 if item0 != null])
    "splitDNS"              = (var.split_dns == null ? null : [for item0 in var.split_dns : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/microsoftTunnelConfigurations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
