# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "identity"    = (var.identity == null ? null : { for key0, value0 in { "@odata.type" = var.identity["odata_type"], "application" = var.identity["application"], "device" = var.identity["device"], "group" = var.identity["group"], "sharePointGroup" = (var.identity["sharePointGroup"] == null ? null : { for key1, value1 in { "@odata.type" = var.identity["sharePointGroup"]["odata_type"], "displayName" = var.identity["sharePointGroup"]["displayName"], "id" = var.identity["sharePointGroup"]["id"] } : key1 => value1 if value1 != null }), "siteGroup" = (var.identity["siteGroup"] == null ? null : { for key1, value1 in { "@odata.type" = var.identity["siteGroup"]["odata_type"], "displayName" = var.identity["siteGroup"]["displayName"], "id" = var.identity["siteGroup"]["id"], "loginName" = var.identity["siteGroup"]["loginName"] } : key1 => value1 if value1 != null }), "siteUser" = (var.identity["siteUser"] == null ? null : { for key1, value1 in { "@odata.type" = var.identity["siteUser"]["odata_type"], "displayName" = var.identity["siteUser"]["displayName"], "id" = var.identity["siteUser"]["id"], "loginName" = var.identity["siteUser"]["loginName"] } : key1 => value1 if value1 != null }), "user" = var.identity["user"] } : key0 => value0 if value0 != null })
    "@odata.type" = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "storage/fileStorage/containers/${urlencode(var.fileStorageContainer-id)}/sharePointGroups/${urlencode(var.sharePointGroup-id)}/members"
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
