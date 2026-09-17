# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "agentCard"                  = var.agent_card
    "agentIdentityBlueprintId"   = var.agent_identity_blueprint_id
    "agentIdentityId"            = var.agent_identity_id
    "createdBy"                  = var.created_by
    "description"                = var.description
    "displayName"                = var.display_name
    "lastPublishedBy"            = var.last_published_by
    "managedByAppId"             = var.managed_by_app_id
    "@odata.type"                = var.odata_type
    "originatingStore"           = var.originating_store
    "ownerIds"                   = (var.owner_ids == null ? null : [for item0 in var.owner_ids : item0 if item0 != null])
    "sourceAgentId"              = var.source_agent_id
    "sourceCreatedDateTime"      = var.source_created_date_time
    "sourceLastModifiedDateTime" = var.source_last_modified_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "copilot/agentRegistrations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
