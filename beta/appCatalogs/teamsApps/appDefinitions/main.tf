# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedInstallationScopes" = var.allowedInstallationScopes
    "authorization"             = (var.authorization == null ? null : { for key0, value0 in { "@odata.type" = var.authorization["odata_type"], "clientAppId" = var.authorization["clientAppId"], "requiredPermissionSet" = (var.authorization["requiredPermissionSet"] == null ? null : { for key1, value1 in { "@odata.type" = var.authorization["requiredPermissionSet"]["odata_type"], "resourceSpecificPermissions" = (var.authorization["requiredPermissionSet"]["resourceSpecificPermissions"] == null ? null : [for item2 in var.authorization["requiredPermissionSet"]["resourceSpecificPermissions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "permissionType" = item2["permissionType"], "permissionValue" = item2["permissionValue"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "azureADAppId"              = var.azureADAppId
    "bot"                       = var.bot
    "colorIcon"                 = var.colorIcon
    "createdBy"                 = var.createdBy
    "dashboardCards"            = (var.dashboardCards == null ? null : [for item0 in var.dashboardCards : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "contentSource" = (item0["contentSource"] == null ? null : { for key2, value2 in { "@odata.type" = item0["contentSource"]["odata_type"], "botConfiguration" = (item0["contentSource"]["botConfiguration"] == null ? null : { for key3, value3 in { "@odata.type" = item0["contentSource"]["botConfiguration"]["odata_type"], "botId" = item0["contentSource"]["botConfiguration"]["botId"] } : key3 => value3 if value3 != null }), "sourceType" = item0["contentSource"]["sourceType"] } : key2 => value2 if value2 != null }), "defaultSize" = item0["defaultSize"], "description" = item0["description"], "displayName" = item0["displayName"], "icon" = (item0["icon"] == null ? null : { for key2, value2 in { "@odata.type" = item0["icon"]["odata_type"], "iconUrl" = item0["icon"]["iconUrl"], "officeUIFabricIconName" = item0["icon"]["officeUIFabricIconName"] } : key2 => value2 if value2 != null }), "pickerGroupId" = item0["pickerGroupId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"               = var.description
    "displayName"               = var.displayName
    "version"                   = var.graph_version
    "lastModifiedDateTime"      = var.lastModifiedDateTime
    "@odata.type"               = var.odata_type
    "outlineIcon"               = var.outlineIcon
    "publishingState"           = var.publishingState
    "shortdescription"          = var.shortdescription
    "teamsAppId"                = var.teamsAppId
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "appCatalogs/teamsApps/${urlencode(var.teamsApp-id)}/appDefinitions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["bot", "colorIcon", "dashboardCards", "outlineIcon"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
