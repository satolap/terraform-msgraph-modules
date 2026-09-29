# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "banners"                  = (var.banners == null ? null : [for item0 in var.banners : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "banner" = item0["banner"], "firstSeenDateTime" = item0["firstSeenDateTime"], "lastSeenDateTime" = item0["lastSeenDateTime"], "scanProtocol" = item0["scanProtocol"], "timesObserved" = item0["timesObserved"] } : key1 => value1 if value1 != null }) if item0 != null])
    "firstSeenDateTime"        = var.first_seen_date_time
    "host"                     = var.host
    "lastScanDateTime"         = var.last_scan_date_time
    "lastSeenDateTime"         = var.last_seen_date_time
    "mostRecentSslCertificate" = var.most_recent_ssl_certificate
    "@odata.type"              = var.odata_type
    "port"                     = var.port
    "protocol"                 = var.protocol
    "services"                 = (var.services == null ? null : [for item0 in var.services : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "component" = item0["component"], "firstSeenDateTime" = item0["firstSeenDateTime"], "isRecent" = item0["isRecent"], "lastSeenDateTime" = item0["lastSeenDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "status"                   = var.status
    "timesObserved"            = var.times_observed
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/threatIntelligence/hostPorts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
