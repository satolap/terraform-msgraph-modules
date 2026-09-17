# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "firstSeenDateTime" = var.first_seen_date_time
    "host"              = var.host
    "lastSeenDateTime"  = var.last_seen_date_time
    "@odata.type"       = var.odata_type
    "ports"             = (var.ports == null ? null : [for item0 in var.ports : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "firstSeenDateTime" = item0["firstSeenDateTime"], "lastSeenDateTime" = item0["lastSeenDateTime"], "port" = item0["port"] } : key1 => value1 if value1 != null }) if item0 != null])
    "sslCertificate"    = var.ssl_certificate
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/threatIntelligence/hostSslCertificates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
