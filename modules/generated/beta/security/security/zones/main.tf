# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "created"      = (var.created == null ? null : { for key0, value0 in { "@odata.type" = var.created["odata_type"], "by" = var.created["by"], "dateTime" = var.created["dateTime"] } : key0 => value0 if value0 != null })
    "description"  = var.description
    "displayName"  = var.display_name
    "environments" = (var.environments == null ? null : [for item0 in var.environments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "kind" = item0["kind"] } : key1 => value1 if value1 != null }) if item0 != null])
    "modified"     = (var.modified == null ? null : { for key0, value0 in { "@odata.type" = var.modified["odata_type"], "by" = var.modified["by"], "dateTime" = var.modified["dateTime"] } : key0 => value0 if value0 != null })
    "@odata.type"  = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/zones"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
