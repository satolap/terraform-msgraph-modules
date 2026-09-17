# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName" = var.display_name
    "@odata.type" = var.odata_type
    "roles"       = (var.roles == null ? null : [for item0 in var.roles : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "code" = item0["code"], "value" = (item0["value"] == null ? null : { for key2, value2 in { "@odata.type" = item0["value"]["odata_type"], "code" = item0["value"]["code"], "displayName" = item0["value"]["displayName"], "isDisabled" = item0["value"]["isDisabled"], "referenceType" = item0["value"]["referenceType"], "sortIndex" = item0["value"]["sortIndex"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "external/industryData/roleGroups"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
