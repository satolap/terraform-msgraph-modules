# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName" = var.displayName
    "endDate"     = var.endDate
    "@odata.type" = var.odata_type
    "startDate"   = var.startDate
    "year"        = (var.year == null ? null : { for key0, value0 in { "@odata.type" = var.year["odata_type"], "code" = var.year["code"], "value" = (var.year["value"] == null ? null : { for key1, value1 in { "@odata.type" = var.year["value"]["odata_type"], "code" = var.year["value"]["code"], "displayName" = var.year["value"]["displayName"], "isDisabled" = var.year["value"]["isDisabled"], "referenceType" = var.year["value"]["referenceType"], "sortIndex" = var.year["value"]["sortIndex"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "external/industryData/years"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
