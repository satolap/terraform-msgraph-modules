# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "acl"                        = (var.acl == null ? null : [for item0 in var.acl : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accessType" = item0["accessType"], "type" = item0["type"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "activities"                 = (var.activities == null ? null : [for item0 in var.activities : item0 if item0 != null])
    "content"                    = (var.content == null ? null : { for key0, value0 in { "@odata.type" = var.content["odata_type"], "type" = var.content["type"], "value" = var.content["value"] } : key0 => value0 if value0 != null })
    "informationProtectionLabel" = (var.information_protection_label == null ? null : { for key0, value0 in { "@odata.type" = var.information_protection_label["odata_type"], "sensitivityLabelId" = var.information_protection_label["sensitivityLabelId"] } : key0 => value0 if value0 != null })
    "@odata.type"                = var.odata_type
    "properties"                 = var.properties
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "connections/${urlencode(var.external_connection_id)}/items"
  api_version             = "v1.0"
  update_method           = "PUT"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
