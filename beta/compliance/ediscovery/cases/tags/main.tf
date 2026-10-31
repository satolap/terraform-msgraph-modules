# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "childSelectability"   = var.childSelectability
    "childTags"            = (var.childTags == null ? null : [for item0 in var.childTags : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "childSelectability" = item0["childSelectability"], "childTags" = (item0["childTags"] == null ? null : [for item2 in item0["childTags"] : item2 if item2 != null]), "createdBy" = item0["createdBy"], "description" = item0["description"], "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "parent" = item0["parent"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdBy"            = var.createdBy
    "description"          = var.description
    "displayName"          = var.displayName
    "lastModifiedDateTime" = var.lastModifiedDateTime
    "@odata.type"          = var.odata_type
    "parent"               = var.parent
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "compliance/ediscovery/cases/${urlencode(var.case-id)}/tags"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["childTags", "parent"], name)])]))))] } : null

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
