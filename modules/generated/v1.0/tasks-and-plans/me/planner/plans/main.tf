# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "container"   = (var.container == null ? null : { for key0, value0 in { "@odata.type" = var.container["odata_type"], "containerId" = var.container["containerId"], "type" = var.container["type"], "url" = var.container["url"] } : key0 => value0 if value0 != null })
    "@odata.type" = var.odata_type
    "owner"       = var.owner
    "title"       = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/planner/plans"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
