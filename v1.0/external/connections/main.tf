# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activitySettings" = (var.activitySettings == null ? null : { for key0, value0 in { "@odata.type" = var.activitySettings["odata_type"], "urlToItemResolvers" = (var.activitySettings["urlToItemResolvers"] == null ? null : [for item1 in var.activitySettings["urlToItemResolvers"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
    "configuration"    = (var.configuration == null ? null : { for key0, value0 in { "@odata.type" = var.configuration["odata_type"], "authorizedAppIds" = (var.configuration["authorizedAppIds"] == null ? null : [for item1 in var.configuration["authorizedAppIds"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
    "connectorId"      = var.connectorId
    "contentCategory"  = var.contentCategory
    "description"      = var.description
    "groups"           = (var.groups == null ? null : [for item0 in var.groups : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "displayName" = item0["displayName"], "members" = (item0["members"] == null ? null : [for item2 in item0["members"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "items"            = (var.items == null ? null : [for item0 in var.items : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "acl" = (item0["acl"] == null ? null : [for item2 in item0["acl"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "accessType" = item2["accessType"], "type" = item2["type"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "activities" = (item0["activities"] == null ? null : [for item2 in item0["activities"] : item2 if item2 != null]), "content" = (item0["content"] == null ? null : { for key2, value2 in { "@odata.type" = item0["content"]["odata_type"], "type" = item0["content"]["type"], "value" = item0["content"]["value"] } : key2 => value2 if value2 != null }), "informationProtectionLabel" = (item0["informationProtectionLabel"] == null ? null : { for key2, value2 in { "@odata.type" = item0["informationProtectionLabel"]["odata_type"], "sensitivityLabelId" = item0["informationProtectionLabel"]["sensitivityLabelId"] } : key2 => value2 if value2 != null }), "properties" = item0["properties"] } : key1 => value1 if value1 != null }) if item0 != null])
    "name"             = var.name
    "@odata.type"      = var.odata_type
    "operations"       = (var.operations == null ? null : [for item0 in var.operations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "error" = (item0["error"] == null ? null : { for key2, value2 in { "@odata.type" = item0["error"]["odata_type"], "code" = item0["error"]["code"], "details" = (item0["error"]["details"] == null ? null : [for item3 in item0["error"]["details"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "code" = item3["code"], "message" = item3["message"], "target" = item3["target"] } : key4 => value4 if value4 != null }) if item3 != null]), "innerError" = (item0["error"]["innerError"] == null ? null : { for key3, value3 in { "@odata.type" = item0["error"]["innerError"]["odata_type"], "code" = item0["error"]["innerError"]["code"], "details" = (item0["error"]["innerError"]["details"] == null ? null : [for item4 in item0["error"]["innerError"]["details"] : item4 if item4 != null]), "message" = item0["error"]["innerError"]["message"], "target" = item0["error"]["innerError"]["target"] } : key3 => value3 if value3 != null }), "message" = item0["error"]["message"], "target" = item0["error"]["target"] } : key2 => value2 if value2 != null }), "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "schema"           = var.schema
    "searchSettings"   = (var.searchSettings == null ? null : { for key0, value0 in { "@odata.type" = var.searchSettings["odata_type"], "searchResultTemplates" = (var.searchSettings["searchResultTemplates"] == null ? null : [for item1 in var.searchSettings["searchResultTemplates"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "id" = item1["id"], "layout" = item1["layout"], "priority" = item1["priority"], "rules" = (item1["rules"] == null ? null : [for item3 in item1["rules"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "operation" = item3["operation"], "property" = item3["property"], "values" = item3["values"], "valuesJoinedBy" = item3["valuesJoinedBy"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "external/connections"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["groups", "items", "operations", "schema"], name)])]))))] } : null

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
