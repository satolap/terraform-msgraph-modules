# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"        = var.odata_type
    "dataConnector"      = var.data_connector
    "dataDomain"         = var.data_domain
    "displayName"        = var.display_name
    "effectiveDateTime"  = var.effective_date_time
    "expirationDateTime" = var.expiration_date_time
    "year"               = (var.year == null ? null : { for key0, value0 in { "@odata.type" = var.year["odata_type"], "displayName" = var.year["displayName"], "endDate" = var.year["endDate"], "startDate" = var.year["startDate"], "year" = (var.year["year"] == null ? null : { for key1, value1 in { "@odata.type" = var.year["year"]["odata_type"], "code" = var.year["year"]["code"], "value" = (var.year["year"]["value"] == null ? null : { for key2, value2 in { "@odata.type" = var.year["year"]["value"]["odata_type"], "code" = var.year["year"]["value"]["code"], "displayName" = var.year["year"]["value"]["displayName"], "isDisabled" = var.year["year"]["value"]["isDisabled"], "referenceType" = var.year["year"]["value"]["referenceType"], "sortIndex" = var.year["year"]["value"]["sortIndex"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "external/industryData/inboundFlows"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
