# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "authorization"        = (var.authorization == null ? null : { for key0, value0 in { "@odata.type" = var.authorization["odata_type"], "clientAppId" = var.authorization["clientAppId"], "requiredPermissionSet" = (var.authorization["requiredPermissionSet"] == null ? null : { for key1, value1 in { "@odata.type" = var.authorization["requiredPermissionSet"]["odata_type"], "resourceSpecificPermissions" = (var.authorization["requiredPermissionSet"]["resourceSpecificPermissions"] == null ? null : [for item2 in var.authorization["requiredPermissionSet"]["resourceSpecificPermissions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "permissionType" = item2["permissionType"], "permissionValue" = item2["permissionValue"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "bot"                  = var.bot
    "createdBy"            = var.created_by
    "description"          = var.description
    "displayName"          = var.display_name
    "version"              = var.graph_version
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "publishingState"      = var.publishing_state
    "shortDescription"     = var.short_description
    "teamsAppId"           = var.teams_app_id_2
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "appCatalogs/teamsApps/${urlencode(var.teams_app_id)}/appDefinitions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
