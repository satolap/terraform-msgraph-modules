# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "artifact"          = (var.artifact == null ? null : { for key0, value0 in { "@odata.type" = var.artifact["odata_type"] } : key0 => value0 if value0 != null })
    "firstSeenDateTime" = var.first_seen_date_time
    "source"            = var.graph_source
    "lastSeenDateTime"  = var.last_seen_date_time
    "@odata.type"       = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/threatIntelligence/intelligenceProfileIndicators"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
