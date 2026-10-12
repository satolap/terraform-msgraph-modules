# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "definitions" = (var.definitions == null ? null : [for item0 in var.definitions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "audience" = item0["audience"], "categories" = (item0["categories"] == null ? null : [for item2 in item0["categories"] : item2 if item2 != null]), "description" = item0["description"], "displayName" = item0["displayName"], "iconUrl" = item0["iconUrl"], "languageTag" = item0["languageTag"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "parentTemplateId" = item0["parentTemplateId"], "publisherName" = item0["publisherName"], "shortDescription" = item0["shortDescription"], "teamDefinition" = item0["teamDefinition"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type" = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teamwork/teamTemplates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
