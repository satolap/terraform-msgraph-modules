locals {
  # The derived @odata.type is required on create and on every update, and each
  # range carries its own type. Ranges are sorted so that caller order never
  # causes an update; the provider compares arrays by position.
  body = {
    "@odata.type" = "#microsoft.graph.ipNamedLocation"
    displayName   = var.display_name
    isTrusted     = var.is_trusted
    ipRanges = [for r in sort(var.ip_ranges) : {
      "@odata.type" = strcontains(r, ":") ? "#microsoft.graph.iPv6CidrRange" : "#microsoft.graph.iPv4CidrRange"
      cidrAddress   = r
    }]
  }
}

resource "msgraph_resource" "named_location" {
  url                     = "identity/conditionalAccess/namedLocations"
  api_version             = var.api_version
  body                    = local.body
  ignore_missing_property = false

  response_export_values = {
    display_name = "displayName"
    is_trusted   = "isTrusted"
    ip_ranges    = "ipRanges[].cidrAddress"
  }

  timeouts {
    create = var.timeouts.create
    read   = var.timeouts.read
    update = var.timeouts.update
    delete = var.timeouts.delete
  }
}
