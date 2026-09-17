# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "childFolderCount"              = var.child_folder_count
    "childFolders"                  = (var.child_folders == null ? null : [for item0 in var.child_folders : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "childFolderCount" = item0["childFolderCount"], "childFolders" = (item0["childFolders"] == null ? null : [for item2 in item0["childFolders"] : item2 if item2 != null]), "displayName" = item0["displayName"], "items" = (item0["items"] == null ? null : [for item2 in item0["items"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "categories" = (item2["categories"] == null ? null : [for item4 in item2["categories"] : item4 if item4 != null]), "createdDateTime" = item2["createdDateTime"], "lastModifiedDateTime" = item2["lastModifiedDateTime"], "multiValueExtendedProperties" = (item2["multiValueExtendedProperties"] == null ? null : [for item4 in item2["multiValueExtendedProperties"] : item4 if item4 != null]), "singleValueExtendedProperties" = (item2["singleValueExtendedProperties"] == null ? null : [for item4 in item2["singleValueExtendedProperties"] : item4 if item4 != null]), "size" = item2["size"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]), "multiValueExtendedProperties" = (item0["multiValueExtendedProperties"] == null ? null : [for item2 in item0["multiValueExtendedProperties"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "value" = (item2["value"] == null ? null : [for item4 in item2["value"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }) if item2 != null]), "parentFolderId" = item0["parentFolderId"], "parentMailboxUrl" = item0["parentMailboxUrl"], "singleValueExtendedProperties" = (item0["singleValueExtendedProperties"] == null ? null : [for item2 in item0["singleValueExtendedProperties"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "totalItemCount" = item0["totalItemCount"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"                   = var.display_name
    "items"                         = (var.items == null ? null : [for item0 in var.items : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "categories" = (item0["categories"] == null ? null : [for item2 in item0["categories"] : item2 if item2 != null]), "createdDateTime" = item0["createdDateTime"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "multiValueExtendedProperties" = (item0["multiValueExtendedProperties"] == null ? null : [for item2 in item0["multiValueExtendedProperties"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "value" = (item2["value"] == null ? null : [for item4 in item2["value"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }) if item2 != null]), "singleValueExtendedProperties" = (item0["singleValueExtendedProperties"] == null ? null : [for item2 in item0["singleValueExtendedProperties"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "size" = item0["size"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "multiValueExtendedProperties"  = (var.multi_value_extended_properties == null ? null : [for item0 in var.multi_value_extended_properties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "value" = (item0["value"] == null ? null : [for item2 in item0["value"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                   = var.odata_type
    "parentFolderId"                = var.parent_folder_id
    "parentMailboxUrl"              = var.parent_mailbox_url
    "singleValueExtendedProperties" = (var.single_value_extended_properties == null ? null : [for item0 in var.single_value_extended_properties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "totalItemCount"                = var.total_item_count
    "type"                          = var.type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/exchange/mailboxes/${urlencode(var.mailbox_id)}/folders"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
