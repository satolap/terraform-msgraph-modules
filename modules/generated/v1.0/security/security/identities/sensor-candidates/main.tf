# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "computerDnsName"    = var.computer_dns_name
    "domainName"         = var.domain_name
    "lastSeenDateTime"   = var.last_seen_date_time
    "@odata.type"        = var.odata_type
    "senseClientVersion" = var.sense_client_version
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/identities/sensorCandidates"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
