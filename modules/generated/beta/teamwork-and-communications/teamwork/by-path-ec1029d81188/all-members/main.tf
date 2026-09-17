# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"                 = var.display_name
    "@odata.type"                 = var.odata_type
    "roles"                       = (var.roles == null ? null : [for item0 in var.roles : item0 if item0 != null])
    "visibleHistoryStartDateTime" = var.visible_history_start_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teamwork/teamTemplates/${urlencode(var.team_template_id)}/definitions/${urlencode(var.team_template_definition_id)}/teamDefinition/channels/${urlencode(var.channel_id)}/allMembers"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
