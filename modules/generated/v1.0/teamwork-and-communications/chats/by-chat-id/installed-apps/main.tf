# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "consentedPermissionSet" = var.consented_permission_set
    "@odata.type"            = var.odata_type
    "teamsApp"               = var.teams_app
    "teamsAppDefinition"     = var.teams_app_definition
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "chats/${urlencode(var.chat_id)}/installedApps"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
