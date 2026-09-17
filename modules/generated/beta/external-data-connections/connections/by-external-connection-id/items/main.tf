# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "acl"                        = (var.acl == null ? null : [for item0 in var.acl : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accessType" = item0["accessType"], "identitySource" = item0["identitySource"], "type" = item0["type"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "activities"                 = (var.activities == null ? null : [for item0 in var.activities : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "performedBy" = item0["performedBy"], "startDateTime" = item0["startDateTime"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "content"                    = var.content
    "informationProtectionLabel" = var.information_protection_label
    "@odata.type"                = var.odata_type
    "properties"                 = var.properties
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "connections/${urlencode(var.external_connection_id)}/items"
  api_version             = "beta"
  update_method           = "PUT"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
