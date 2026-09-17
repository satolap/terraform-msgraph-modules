# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deletedDateTime" = var.deleted_date_time
    "folders"         = (var.folders == null ? null : [for item0 in var.folders : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "childFolderCount" = item0["childFolderCount"], "childFolders" = (item0["childFolders"] == null ? null : [for item2 in item0["childFolders"] : item2 if item2 != null]), "displayName" = item0["displayName"], "items" = (item0["items"] == null ? null : [for item2 in item0["items"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "categories" = (item2["categories"] == null ? null : [for item4 in item2["categories"] : item4 if item4 != null]), "createdDateTime" = item2["createdDateTime"], "lastModifiedDateTime" = item2["lastModifiedDateTime"], "multiValueExtendedProperties" = (item2["multiValueExtendedProperties"] == null ? null : [for item4 in item2["multiValueExtendedProperties"] : item4 if item4 != null]), "singleValueExtendedProperties" = (item2["singleValueExtendedProperties"] == null ? null : [for item4 in item2["singleValueExtendedProperties"] : item4 if item4 != null]), "size" = item2["size"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]), "multiValueExtendedProperties" = (item0["multiValueExtendedProperties"] == null ? null : [for item2 in item0["multiValueExtendedProperties"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "value" = (item2["value"] == null ? null : [for item4 in item2["value"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }) if item2 != null]), "parentFolderId" = item0["parentFolderId"], "singleValueExtendedProperties" = (item0["singleValueExtendedProperties"] == null ? null : [for item2 in item0["singleValueExtendedProperties"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "totalItemCount" = item0["totalItemCount"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"     = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/exchange/mailboxes"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
