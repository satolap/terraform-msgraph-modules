# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "controls"    = (var.controls == null ? null : [for item0 in var.controls : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "controlId" = item0["controlId"], "controlTypeId" = item0["controlTypeId"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "owner" = item0["owner"], "program" = item0["program"], "programId" = item0["programId"], "resource" = (item0["resource"] == null ? null : { for key2, value2 in { "@odata.type" = item0["resource"]["odata_type"], "displayName" = item0["resource"]["displayName"], "id" = item0["resource"]["id"], "type" = item0["resource"]["type"] } : key2 => value2 if value2 != null }), "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description" = var.description
    "displayName" = var.display_name
    "@odata.type" = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "programs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["controls"], name)])]))))] } : null

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
