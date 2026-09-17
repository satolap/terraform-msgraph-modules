# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description" = var.description
    "@odata.type" = var.odata_type
    "properties"  = (var.properties == null ? null : [for item0 in var.properties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "status"      = var.status
    "targetTypes" = (var.target_types == null ? null : [for item0 in var.target_types : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "schemaExtensions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
