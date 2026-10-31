# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "advancedSettings"      = (var.advancedSettings == null ? null : [for item0 in var.advancedSettings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "defaultDomainSuffix"   = var.defaultDomainSuffix
    "description"           = var.description
    "disableUdpConnections" = var.disableUdpConnections
    "displayName"           = var.displayName
    "dnsServers"            = (var.dnsServers == null ? null : [for item0 in var.dnsServers : item0 if item0 != null])
    "ipv6Network"           = var.ipv6Network
    "lastUpdateDateTime"    = var.lastUpdateDateTime
    "listenPort"            = var.listenPort
    "network"               = var.network
    "@odata.type"           = var.odata_type
    "roleScopeTagIds"       = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
    "routeExcludes"         = (var.routeExcludes == null ? null : [for item0 in var.routeExcludes : item0 if item0 != null])
    "routeIncludes"         = (var.routeIncludes == null ? null : [for item0 in var.routeIncludes : item0 if item0 != null])
    "routesExclude"         = (var.routesExclude == null ? null : [for item0 in var.routesExclude : item0 if item0 != null])
    "routesInclude"         = (var.routesInclude == null ? null : [for item0 in var.routesInclude : item0 if item0 != null])
    "splitDNS"              = (var.splitDNS == null ? null : [for item0 in var.splitDNS : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/microsoftTunnelConfigurations"
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
