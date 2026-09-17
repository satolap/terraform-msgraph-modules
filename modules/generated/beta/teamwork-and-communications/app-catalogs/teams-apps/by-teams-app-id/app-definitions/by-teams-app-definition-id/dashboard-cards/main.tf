# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "contentSource" = var.content_source
    "defaultSize"   = var.default_size
    "description"   = var.description
    "displayName"   = var.display_name
    "icon"          = var.icon
    "@odata.type"   = var.odata_type
    "pickerGroupId" = var.picker_group_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "appCatalogs/teamsApps/${urlencode(var.teams_app_id)}/appDefinitions/${urlencode(var.teams_app_definition_id)}/dashboardCards"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
