# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "children"     = (var.children == null ? null : [for item0 in var.children : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "children" = (item0["children"] == null ? null : [for item2 in item0["children"] : item2 if item2 != null]), "descriptions" = (item0["descriptions"] == null ? null : [for item2 in item0["descriptions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "description" = item2["description"], "languageTag" = item2["languageTag"] } : key3 => value3 if value3 != null }) if item2 != null]), "labels" = (item0["labels"] == null ? null : [for item2 in item0["labels"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "isDefault" = item2["isDefault"], "languageTag" = item2["languageTag"], "name" = item2["name"] } : key3 => value3 if value3 != null }) if item2 != null]), "properties" = (item0["properties"] == null ? null : [for item2 in item0["properties"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "key" = item2["key"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "relations" = (item0["relations"] == null ? null : [for item2 in item0["relations"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "fromTerm" = item2["fromTerm"], "relationship" = item2["relationship"], "set" = item2["set"], "toTerm" = item2["toTerm"] } : key3 => value3 if value3 != null }) if item2 != null]), "set" = item0["set"] } : key1 => value1 if value1 != null }) if item0 != null])
    "descriptions" = (var.descriptions == null ? null : [for item0 in var.descriptions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "languageTag" = item0["languageTag"] } : key1 => value1 if value1 != null }) if item0 != null])
    "labels"       = (var.labels == null ? null : [for item0 in var.labels : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isDefault" = item0["isDefault"], "languageTag" = item0["languageTag"], "name" = item0["name"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"  = var.odata_type
    "properties"   = (var.properties == null ? null : [for item0 in var.properties : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "key" = item0["key"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "relations"    = (var.relations == null ? null : [for item0 in var.relations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "fromTerm" = item0["fromTerm"], "relationship" = item0["relationship"], "set" = item0["set"], "toTerm" = item0["toTerm"] } : key1 => value1 if value1 != null }) if item0 != null])
    "set"          = var.set
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "sites/${urlencode(var.site_id)}/termStore/groups/${urlencode(var.group_id)}/sets/${urlencode(var.set_id)}/terms/${urlencode(var.term_id)}/children"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
