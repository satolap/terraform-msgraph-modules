# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime" = var.created_date_time
    "numbers"         = (var.numbers == null ? null : [for item0 in var.numbers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "resourceLocation" = item0["resourceLocation"], "status" = item0["status"], "statusDetail" = item0["statusDetail"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"     = var.odata_type
    "status"          = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/teams/telephoneNumberManagement/operations"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
