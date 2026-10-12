# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "applicationId" = var.application_id_2
    "default"       = var.default
    "description"   = var.description
    "discoverable"  = var.discoverable
    "factoryTag"    = var.factory_tag
    "metadata"      = (var.metadata == null ? null : [for item0 in var.metadata : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "key" = item0["key"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"   = var.odata_type
    "schema"        = var.schema
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "applications/${urlencode(var.application_id)}/synchronization/templates"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
