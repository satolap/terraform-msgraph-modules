# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"  = var.description
    "displayName"  = var.display_name
    "@odata.type"  = var.odata_type
    "parentSiteId" = var.parent_site_id
    "scope"        = var.scope
    "sets"         = (var.sets == null ? null : [for item0 in var.sets : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "children" = (item0["children"] == null ? null : [for item2 in item0["children"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "children" = (item2["children"] == null ? null : [for item4 in item2["children"] : item4 if item4 != null]), "descriptions" = (item2["descriptions"] == null ? null : [for item4 in item2["descriptions"] : item4 if item4 != null]), "labels" = (item2["labels"] == null ? null : [for item4 in item2["labels"] : item4 if item4 != null]), "properties" = (item2["properties"] == null ? null : [for item4 in item2["properties"] : item4 if item4 != null]), "relations" = (item2["relations"] == null ? null : [for item4 in item2["relations"] : item4 if item4 != null]), "set" = item2["set"] } : key3 => value3 if value3 != null }) if item2 != null]), "description" = item0["description"], "localizedNames" = (item0["localizedNames"] == null ? null : [for item2 in item0["localizedNames"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "languageTag" = item2["languageTag"], "name" = item2["name"] } : key3 => value3 if value3 != null }) if item2 != null]), "parentGroup" = (item0["parentGroup"] == null ? null : { for key2, value2 in { "@odata.type" = item0["parentGroup"]["odata_type"], "description" = item0["parentGroup"]["description"], "displayName" = item0["parentGroup"]["displayName"], "parentSiteId" = item0["parentGroup"]["parentSiteId"], "scope" = item0["parentGroup"]["scope"], "sets" = (item0["parentGroup"]["sets"] == null ? null : [for item3 in item0["parentGroup"]["sets"] : item3 if item3 != null]) } : key2 => value2 if value2 != null }), "properties" = (item0["properties"] == null ? null : [for item2 in item0["properties"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "key" = item2["key"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "relations" = (item0["relations"] == null ? null : [for item2 in item0["relations"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "fromTerm" = item2["fromTerm"], "relationship" = item2["relationship"], "set" = item2["set"], "toTerm" = item2["toTerm"] } : key3 => value3 if value3 != null }) if item2 != null]), "terms" = (item0["terms"] == null ? null : [for item2 in item0["terms"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "children" = (item2["children"] == null ? null : [for item4 in item2["children"] : item4 if item4 != null]), "descriptions" = (item2["descriptions"] == null ? null : [for item4 in item2["descriptions"] : item4 if item4 != null]), "labels" = (item2["labels"] == null ? null : [for item4 in item2["labels"] : item4 if item4 != null]), "properties" = (item2["properties"] == null ? null : [for item4 in item2["properties"] : item4 if item4 != null]), "relations" = (item2["relations"] == null ? null : [for item4 in item2["relations"] : item4 if item4 != null]), "set" = item2["set"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "sites/${urlencode(var.site_id)}/termStore/groups"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
