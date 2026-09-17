# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "controls"    = (var.controls == null ? null : [for item0 in var.controls : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "controlId" = item0["controlId"], "controlTypeId" = item0["controlTypeId"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "owner" = item0["owner"], "program" = item0["program"], "programId" = item0["programId"], "resource" = item0["resource"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description" = var.description
    "displayName" = var.display_name
    "@odata.type" = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "programs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
