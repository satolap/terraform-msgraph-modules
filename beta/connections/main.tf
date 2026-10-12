# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activitySettings"          = (var.activity_settings == null ? null : { for key0, value0 in { "@odata.type" = var.activity_settings["odata_type"], "urlToItemResolvers" = (var.activity_settings["urlToItemResolvers"] == null ? null : [for item1 in var.activity_settings["urlToItemResolvers"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
    "complianceSettings"        = (var.compliance_settings == null ? null : { for key0, value0 in { "@odata.type" = var.compliance_settings["odata_type"], "eDiscoveryResultTemplates" = (var.compliance_settings["eDiscoveryResultTemplates"] == null ? null : [for item1 in var.compliance_settings["eDiscoveryResultTemplates"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "id" = item1["id"], "layout" = item1["layout"], "priority" = item1["priority"], "rules" = (item1["rules"] == null ? null : [for item3 in item1["rules"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "operation" = item3["operation"], "property" = item3["property"], "values" = item3["values"], "valuesJoinedBy" = item3["valuesJoinedBy"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "configuration"             = (var.configuration == null ? null : { for key0, value0 in { "@odata.type" = var.configuration["odata_type"], "authorizedAppIds" = (var.configuration["authorizedAppIds"] == null ? null : [for item1 in var.configuration["authorizedAppIds"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
    "connectorId"               = var.connector_id
    "contentCategory"           = var.content_category
    "description"               = var.description
    "enabledContentExperiences" = var.enabled_content_experiences
    "groups"                    = (var.groups == null ? null : [for item0 in var.groups : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "displayName" = item0["displayName"], "members" = (item0["members"] == null ? null : [for item2 in item0["members"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "ingestedItemsCount"        = var.ingested_items_count
    "items"                     = (var.items == null ? null : [for item0 in var.items : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "acl" = (item0["acl"] == null ? null : [for item2 in item0["acl"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "accessType" = item2["accessType"], "identitySource" = item2["identitySource"], "type" = item2["type"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "activities" = (item0["activities"] == null ? null : [for item2 in item0["activities"] : item2 if item2 != null]), "content" = (item0["content"] == null ? null : { for key2, value2 in { "@odata.type" = item0["content"]["odata_type"], "type" = item0["content"]["type"], "value" = item0["content"]["value"] } : key2 => value2 if value2 != null }), "informationProtectionLabel" = (item0["informationProtectionLabel"] == null ? null : { for key2, value2 in { "@odata.type" = item0["informationProtectionLabel"]["odata_type"], "sensitivityLabelId" = item0["informationProtectionLabel"]["sensitivityLabelId"] } : key2 => value2 if value2 != null }), "properties" = item0["properties"] } : key1 => value1 if value1 != null }) if item0 != null])
    "name"                      = var.name
    "@odata.type"               = var.odata_type
    "operations"                = (var.operations == null ? null : [for item0 in var.operations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "error" = (item0["error"] == null ? null : { for key2, value2 in { "@odata.type" = item0["error"]["odata_type"], "code" = item0["error"]["code"], "details" = (item0["error"]["details"] == null ? null : [for item3 in item0["error"]["details"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "code" = item3["code"], "message" = item3["message"], "target" = item3["target"] } : key4 => value4 if value4 != null }) if item3 != null]), "innerError" = (item0["error"]["innerError"] == null ? null : { for key3, value3 in { "@odata.type" = item0["error"]["innerError"]["odata_type"], "code" = item0["error"]["innerError"]["code"], "details" = (item0["error"]["innerError"]["details"] == null ? null : [for item4 in item0["error"]["innerError"]["details"] : item4 if item4 != null]), "message" = item0["error"]["innerError"]["message"], "target" = item0["error"]["innerError"]["target"] } : key3 => value3 if value3 != null }), "message" = item0["error"]["message"], "target" = item0["error"]["target"] } : key2 => value2 if value2 != null }), "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "quota"                     = var.quota
    "schema"                    = var.schema
    "searchSettings"            = (var.search_settings == null ? null : { for key0, value0 in { "@odata.type" = var.search_settings["odata_type"], "searchResultTemplates" = (var.search_settings["searchResultTemplates"] == null ? null : [for item1 in var.search_settings["searchResultTemplates"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "id" = item1["id"], "layout" = item1["layout"], "priority" = item1["priority"], "rules" = (item1["rules"] == null ? null : [for item3 in item1["rules"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "operation" = item3["operation"], "property" = item3["property"], "values" = item3["values"], "valuesJoinedBy" = item3["valuesJoinedBy"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "connections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
