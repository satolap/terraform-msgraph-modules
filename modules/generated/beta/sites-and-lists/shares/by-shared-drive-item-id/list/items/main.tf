# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activities"          = (var.activities == null ? null : [for item0 in var.activities : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "action" = item0["action"], "actor" = item0["actor"], "driveItem" = item0["driveItem"], "listItem" = item0["listItem"], "times" = item0["times"] } : key1 => value1 if value1 != null }) if item0 != null])
    "analytics"           = var.analytics
    "contentType"         = var.content_type
    "createdByUser"       = var.created_by_user
    "deleted"             = var.deleted
    "description"         = var.description
    "documentSetVersions" = (var.document_set_versions == null ? null : [for item0 in var.document_set_versions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "comment" = item0["comment"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "fields" = item0["fields"], "items" = (item0["items"] == null ? null : [for item2 in item0["items"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "itemId" = item2["itemId"], "title" = item2["title"], "versionId" = item2["versionId"] } : key3 => value3 if value3 != null }) if item2 != null]), "shouldCaptureMinorVersion" = item0["shouldCaptureMinorVersion"] } : key1 => value1 if value1 != null }) if item0 != null])
    "driveItem"           = var.drive_item
    "fields"              = var.fields
    "lastModifiedByUser"  = var.last_modified_by_user
    "name"                = var.name
    "@odata.type"         = var.odata_type
    "parentReference"     = var.parent_reference
    "versions"            = (var.versions == null ? null : [for item0 in var.versions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "fields" = item0["fields"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "shares/${urlencode(var.shared_drive_item_id)}/list/items"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
