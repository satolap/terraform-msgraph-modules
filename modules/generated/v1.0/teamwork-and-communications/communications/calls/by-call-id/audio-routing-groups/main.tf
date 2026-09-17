# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type" = var.odata_type
    "receivers"   = (var.receivers == null ? null : [for item0 in var.receivers : item0 if item0 != null])
    "routingMode" = var.routing_mode
    "sources"     = (var.sources == null ? null : [for item0 in var.sources : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "communications/calls/${urlencode(var.call_id)}/audioRoutingGroups"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
