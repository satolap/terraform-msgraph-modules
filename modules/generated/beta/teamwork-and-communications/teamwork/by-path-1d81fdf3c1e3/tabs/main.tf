# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "configuration"  = var.configuration
    "displayName"    = var.display_name
    "messageId"      = var.message_id
    "@odata.type"    = var.odata_type
    "sortOrderIndex" = var.sort_order_index
    "teamsApp"       = var.teams_app
    "teamsAppId"     = var.teams_app_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teamwork/teamTemplates/${urlencode(var.team_template_id)}/definitions/${urlencode(var.team_template_definition_id)}/teamDefinition/channels/${urlencode(var.channel_id)}/tabs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
