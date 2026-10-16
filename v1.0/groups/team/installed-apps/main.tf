# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "consentedPermissionSet" = (var.consented_permission_set == null ? null : { for key0, value0 in { "@odata.type" = var.consented_permission_set["odata_type"], "resourceSpecificPermissions" = (var.consented_permission_set["resourceSpecificPermissions"] == null ? null : [for item1 in var.consented_permission_set["resourceSpecificPermissions"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "permissionType" = item1["permissionType"], "permissionValue" = item1["permissionValue"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "@odata.type"            = var.odata_type
    "teamsApp"               = var.teams_app
    "teamsAppDefinition"     = var.teams_app_definition
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "groups/${urlencode(var.group_id)}/team/installedApps"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
