# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activitySettings"          = var.activity_settings
    "complianceSettings"        = var.compliance_settings
    "configuration"             = var.configuration
    "connectorId"               = var.connector_id
    "contentCategory"           = var.content_category
    "description"               = var.description
    "enabledContentExperiences" = var.enabled_content_experiences
    "groups"                    = (var.groups == null ? null : [for item0 in var.groups : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "description" = item0["description"], "displayName" = item0["displayName"], "members" = (item0["members"] == null ? null : [for item2 in item0["members"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "ingestedItemsCount"        = var.ingested_items_count
    "items"                     = (var.items == null ? null : [for item0 in var.items : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "acl" = (item0["acl"] == null ? null : [for item2 in item0["acl"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "accessType" = item2["accessType"], "identitySource" = item2["identitySource"], "type" = item2["type"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "activities" = (item0["activities"] == null ? null : [for item2 in item0["activities"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "performedBy" = item2["performedBy"], "startDateTime" = item2["startDateTime"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]), "content" = item0["content"], "informationProtectionLabel" = item0["informationProtectionLabel"], "properties" = item0["properties"] } : key1 => value1 if value1 != null }) if item0 != null])
    "name"                      = var.name
    "@odata.type"               = var.odata_type
    "operations"                = (var.operations == null ? null : [for item0 in var.operations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "error" = item0["error"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "quota"                     = var.quota
    "schema"                    = var.schema
    "searchSettings"            = var.search_settings
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "external/connections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
