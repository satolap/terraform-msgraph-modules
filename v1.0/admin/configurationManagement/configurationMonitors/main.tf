# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "baseline"    = (var.baseline == null ? null : { for key0, value0 in { "@odata.type" = var.baseline["odata_type"], "description" = var.baseline["description"], "displayName" = var.baseline["displayName"], "parameters" = (var.baseline["parameters"] == null ? null : [for item1 in var.baseline["parameters"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "description" = item1["description"], "displayName" = item1["displayName"], "parameterType" = item1["parameterType"] } : key2 => value2 if value2 != null }) if item1 != null]), "resources" = (var.baseline["resources"] == null ? null : [for item1 in var.baseline["resources"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "displayName" = item1["displayName"], "properties" = item1["properties"], "resourceType" = item1["resourceType"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "description" = var.description
    "displayName" = var.displayName
    "mode"        = var.mode
    "@odata.type" = var.odata_type
    "parameters"  = var.parameters
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "admin/configurationManagement/configurationMonitors"
  api_version             = "v1.0"
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
