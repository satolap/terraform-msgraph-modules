# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "identity"    = (var.identity == null ? null : { for key0, value0 in { "@odata.type" = var.identity["odata_type"], "application" = var.identity["application"], "device" = var.identity["device"], "group" = var.identity["group"], "sharePointGroup" = (var.identity["sharePointGroup"] == null ? null : { for key1, value1 in { "@odata.type" = var.identity["sharePointGroup"]["odata_type"], "displayName" = var.identity["sharePointGroup"]["displayName"], "id" = var.identity["sharePointGroup"]["id"] } : key1 => value1 if value1 != null }), "siteGroup" = (var.identity["siteGroup"] == null ? null : { for key1, value1 in { "@odata.type" = var.identity["siteGroup"]["odata_type"], "displayName" = var.identity["siteGroup"]["displayName"], "id" = var.identity["siteGroup"]["id"], "loginName" = var.identity["siteGroup"]["loginName"] } : key1 => value1 if value1 != null }), "siteUser" = (var.identity["siteUser"] == null ? null : { for key1, value1 in { "@odata.type" = var.identity["siteUser"]["odata_type"], "displayName" = var.identity["siteUser"]["displayName"], "id" = var.identity["siteUser"]["id"], "loginName" = var.identity["siteUser"]["loginName"] } : key1 => value1 if value1 != null }), "user" = var.identity["user"] } : key0 => value0 if value0 != null })
    "@odata.type" = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "storage/fileStorage/deletedContainers/${urlencode(var.file_storage_container_id)}/sharePointGroups/${urlencode(var.share_point_group_id)}/members"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
