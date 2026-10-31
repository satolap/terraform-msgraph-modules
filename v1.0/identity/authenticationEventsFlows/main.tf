# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type" = var.odata_type
    "conditions"  = (var.conditions == null ? null : { for key0, value0 in { "@odata.type" = var.conditions["odata_type"], "applications" = (var.conditions["applications"] == null ? null : { for key1, value1 in { "@odata.type" = var.conditions["applications"]["odata_type"], "includeApplications" = (var.conditions["applications"]["includeApplications"] == null ? null : [for item2 in var.conditions["applications"]["includeApplications"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "appId" = item2["appId"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "description" = var.description
    "displayName" = var.displayName
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "identity/authenticationEventsFlows"
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
