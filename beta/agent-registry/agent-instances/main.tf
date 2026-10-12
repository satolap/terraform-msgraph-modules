# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "additionalInterfaces"     = (var.additional_interfaces == null ? null : [for item0 in var.additional_interfaces : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "transport" = item0["transport"], "url" = item0["url"] } : key1 => value1 if value1 != null }) if item0 != null])
    "agentCardManifest"        = var.agent_card_manifest
    "agentIdentityBlueprintId" = var.agent_identity_blueprint_id
    "agentIdentityId"          = var.agent_identity_id
    "collections"              = (var.collections == null ? null : [for item0 in var.collections : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "managedBy" = item0["managedBy"], "members" = (item0["members"] == null ? null : [for item2 in item0["members"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "additionalInterfaces" = (item2["additionalInterfaces"] == null ? null : [for item4 in item2["additionalInterfaces"] : item4 if item4 != null]), "agentCardManifest" = item2["agentCardManifest"], "agentIdentityBlueprintId" = item2["agentIdentityBlueprintId"], "agentIdentityId" = item2["agentIdentityId"], "collections" = (item2["collections"] == null ? null : [for item4 in item2["collections"] : item4 if item4 != null]), "displayName" = item2["displayName"], "lastModifiedDateTime" = item2["lastModifiedDateTime"], "managedBy" = item2["managedBy"], "originatingStore" = item2["originatingStore"], "ownerIds" = (item2["ownerIds"] == null ? null : [for item4 in item2["ownerIds"] : item4 if item4 != null]), "preferredTransport" = item2["preferredTransport"], "signatures" = (item2["signatures"] == null ? null : [for item4 in item2["signatures"] : item4 if item4 != null]), "sourceAgentId" = item2["sourceAgentId"], "url" = item2["url"] } : key3 => value3 if value3 != null }) if item2 != null]), "originatingStore" = item0["originatingStore"], "ownerIds" = (item0["ownerIds"] == null ? null : [for item2 in item0["ownerIds"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"              = var.display_name
    "lastModifiedDateTime"     = var.last_modified_date_time
    "managedBy"                = var.managed_by
    "@odata.type"              = var.odata_type
    "originatingStore"         = var.originating_store
    "ownerIds"                 = (var.owner_ids == null ? null : [for item0 in var.owner_ids : item0 if item0 != null])
    "preferredTransport"       = var.preferred_transport
    "signatures"               = (var.signatures == null ? null : [for item0 in var.signatures : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "header" = item0["header"], "protected" = item0["protected"], "signature" = item0["signature"] } : key1 => value1 if value1 != null }) if item0 != null])
    "sourceAgentId"            = var.source_agent_id
    "url"                      = var.url
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "agentRegistry/agentInstances"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
