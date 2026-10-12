# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "contentSource" = (var.content_source == null ? null : { for key0, value0 in { "@odata.type" = var.content_source["odata_type"], "botConfiguration" = (var.content_source["botConfiguration"] == null ? null : { for key1, value1 in { "@odata.type" = var.content_source["botConfiguration"]["odata_type"], "botId" = var.content_source["botConfiguration"]["botId"] } : key1 => value1 if value1 != null }), "sourceType" = var.content_source["sourceType"] } : key0 => value0 if value0 != null })
    "defaultSize"   = var.default_size
    "description"   = var.description
    "displayName"   = var.display_name
    "icon"          = (var.icon == null ? null : { for key0, value0 in { "@odata.type" = var.icon["odata_type"], "iconUrl" = var.icon["iconUrl"], "officeUIFabricIconName" = var.icon["officeUIFabricIconName"] } : key0 => value0 if value0 != null })
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
