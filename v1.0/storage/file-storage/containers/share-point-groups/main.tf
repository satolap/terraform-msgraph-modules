# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description" = var.description
    "members"     = (var.members == null ? null : [for item0 in var.members : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "identity" = (item0["identity"] == null ? null : { for key2, value2 in { "@odata.type" = item0["identity"]["odata_type"], "application" = item0["identity"]["application"], "device" = item0["identity"]["device"], "group" = item0["identity"]["group"], "sharePointGroup" = (item0["identity"]["sharePointGroup"] == null ? null : { for key3, value3 in { "@odata.type" = item0["identity"]["sharePointGroup"]["odata_type"], "displayName" = item0["identity"]["sharePointGroup"]["displayName"], "id" = item0["identity"]["sharePointGroup"]["id"] } : key3 => value3 if value3 != null }), "siteGroup" = (item0["identity"]["siteGroup"] == null ? null : { for key3, value3 in { "@odata.type" = item0["identity"]["siteGroup"]["odata_type"], "displayName" = item0["identity"]["siteGroup"]["displayName"], "id" = item0["identity"]["siteGroup"]["id"], "loginName" = item0["identity"]["siteGroup"]["loginName"] } : key3 => value3 if value3 != null }), "siteUser" = (item0["identity"]["siteUser"] == null ? null : { for key3, value3 in { "@odata.type" = item0["identity"]["siteUser"]["odata_type"], "displayName" = item0["identity"]["siteUser"]["displayName"], "id" = item0["identity"]["siteUser"]["id"], "loginName" = item0["identity"]["siteUser"]["loginName"] } : key3 => value3 if value3 != null }), "user" = item0["identity"]["user"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type" = var.odata_type
    "title"       = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "storage/fileStorage/containers/${urlencode(var.file_storage_container_id)}/sharePointGroups"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
