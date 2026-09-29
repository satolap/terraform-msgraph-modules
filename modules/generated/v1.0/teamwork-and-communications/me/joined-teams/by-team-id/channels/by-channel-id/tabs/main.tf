# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "configuration" = (var.configuration == null ? null : { for key0, value0 in { "@odata.type" = var.configuration["odata_type"], "contentUrl" = var.configuration["contentUrl"], "entityId" = var.configuration["entityId"], "removeUrl" = var.configuration["removeUrl"], "websiteUrl" = var.configuration["websiteUrl"] } : key0 => value0 if value0 != null })
    "displayName"   = var.display_name
    "@odata.type"   = var.odata_type
    "teamsApp"      = var.teams_app
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/joinedTeams/${urlencode(var.team_id)}/channels/${urlencode(var.channel_id)}/tabs"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
