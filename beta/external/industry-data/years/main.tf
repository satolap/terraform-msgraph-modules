# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName" = var.display_name
    "endDate"     = var.end_date
    "@odata.type" = var.odata_type
    "startDate"   = var.start_date
    "year"        = (var.year == null ? null : { for key0, value0 in { "@odata.type" = var.year["odata_type"], "code" = var.year["code"], "value" = (var.year["value"] == null ? null : { for key1, value1 in { "@odata.type" = var.year["value"]["odata_type"], "code" = var.year["value"]["code"], "displayName" = var.year["value"]["displayName"], "isDisabled" = var.year["value"]["isDisabled"], "referenceType" = var.year["value"]["referenceType"], "sortIndex" = var.year["value"]["sortIndex"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "external/industryData/years"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
