# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appDefinitions" = (var.app_definitions == null ? null : [for item0 in var.app_definitions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "authorization" = item0["authorization"], "bot" = item0["bot"], "createdBy" = item0["createdBy"], "description" = item0["description"], "displayName" = item0["displayName"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "publishingState" = item0["publishingState"], "shortDescription" = item0["shortDescription"], "teamsAppId" = item0["teamsAppId"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"    = var.display_name
    "externalId"     = var.external_id
    "@odata.type"    = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "appCatalogs/teamsApps"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
