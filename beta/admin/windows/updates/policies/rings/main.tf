# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"             = var.odata_type
    "deferralInDays"          = var.deferralInDays
    "description"             = var.description
    "displayName"             = var.displayName
    "excludedGroupAssignment" = (var.excludedGroupAssignment == null ? null : { for key0, value0 in { "@odata.type" = var.excludedGroupAssignment["odata_type"], "assignments" = (var.excludedGroupAssignment["assignments"] == null ? null : [for item1 in var.excludedGroupAssignment["assignments"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "group" = item1["group"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "includedGroupAssignment" = (var.includedGroupAssignment == null ? null : { for key0, value0 in { "@odata.type" = var.includedGroupAssignment["odata_type"], "assignments" = (var.includedGroupAssignment["assignments"] == null ? null : [for item1 in var.includedGroupAssignment["assignments"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "group" = item1["group"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "isPaused"                = var.isPaused
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "admin/windows/updates/policies/${urlencode(var.policy-id)}/rings"
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
