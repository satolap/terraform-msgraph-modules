# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "exampleJson" = var.example_json
    "@odata.type" = var.odata_type
    "schemaItems" = (var.schema_items == null ? null : [for item0 in var.schema_items : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "dataType" = item0["dataType"], "defaultBoolValue" = item0["defaultBoolValue"], "defaultIntValue" = item0["defaultIntValue"], "defaultStringArrayValue" = (item0["defaultStringArrayValue"] == null ? null : [for item2 in item0["defaultStringArrayValue"] : item2 if item2 != null]), "defaultStringValue" = item0["defaultStringValue"], "description" = item0["description"], "displayName" = item0["displayName"], "schemaItemKey" = item0["schemaItemKey"], "selections" = (item0["selections"] == null ? null : [for item2 in item0["selections"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "name" = item2["name"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/androidForWorkAppConfigurationSchemas"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
