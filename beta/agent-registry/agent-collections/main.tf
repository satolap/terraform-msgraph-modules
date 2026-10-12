# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"            = var.created_by
    "createdDateTime"      = var.created_date_time
    "description"          = var.description
    "displayName"          = var.display_name
    "lastModifiedDateTime" = var.last_modified_date_time
    "managedBy"            = var.managed_by
    "members"              = (var.members == null ? null : [for item0 in var.members : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "additionalInterfaces" = (item0["additionalInterfaces"] == null ? null : [for item2 in item0["additionalInterfaces"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "transport" = item2["transport"], "url" = item2["url"] } : key3 => value3 if value3 != null }) if item2 != null]), "agentCardManifest" = item0["agentCardManifest"], "agentIdentityBlueprintId" = item0["agentIdentityBlueprintId"], "agentIdentityId" = item0["agentIdentityId"], "collections" = (item0["collections"] == null ? null : [for item2 in item0["collections"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "createdBy" = item2["createdBy"], "createdDateTime" = item2["createdDateTime"], "description" = item2["description"], "displayName" = item2["displayName"], "lastModifiedDateTime" = item2["lastModifiedDateTime"], "managedBy" = item2["managedBy"], "members" = (item2["members"] == null ? null : [for item4 in item2["members"] : item4 if item4 != null]), "originatingStore" = item2["originatingStore"], "ownerIds" = (item2["ownerIds"] == null ? null : [for item4 in item2["ownerIds"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }) if item2 != null]), "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "managedBy" = item0["managedBy"], "originatingStore" = item0["originatingStore"], "ownerIds" = (item0["ownerIds"] == null ? null : [for item2 in item0["ownerIds"] : item2 if item2 != null]), "preferredTransport" = item0["preferredTransport"], "signatures" = (item0["signatures"] == null ? null : [for item2 in item0["signatures"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "header" = item2["header"], "protected" = item2["protected"], "signature" = item2["signature"] } : key3 => value3 if value3 != null }) if item2 != null]), "sourceAgentId" = item0["sourceAgentId"], "url" = item0["url"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"          = var.odata_type
    "originatingStore"     = var.originating_store
    "ownerIds"             = (var.owner_ids == null ? null : [for item0 in var.owner_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "agentRegistry/agentCollections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
