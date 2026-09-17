# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appDefinitions" = (var.app_definitions == null ? null : [for item0 in var.app_definitions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowedInstallationScopes" = item0["allowedInstallationScopes"], "authorization" = item0["authorization"], "azureADAppId" = item0["azureADAppId"], "bot" = item0["bot"], "colorIcon" = item0["colorIcon"], "createdBy" = item0["createdBy"], "dashboardCards" = (item0["dashboardCards"] == null ? null : [for item2 in item0["dashboardCards"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "contentSource" = item2["contentSource"], "defaultSize" = item2["defaultSize"], "description" = item2["description"], "displayName" = item2["displayName"], "icon" = item2["icon"], "pickerGroupId" = item2["pickerGroupId"] } : key3 => value3 if value3 != null }) if item2 != null]), "description" = item0["description"], "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "outlineIcon" = item0["outlineIcon"], "publishingState" = item0["publishingState"], "shortdescription" = item0["shortdescription"], "teamsAppId" = item0["teamsAppId"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"    = var.display_name
    "externalId"     = var.external_id
    "@odata.type"    = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "appCatalogs/teamsApps"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
