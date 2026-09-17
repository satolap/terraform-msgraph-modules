# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "discoverabilities" = var.discoverabilities
    "discoveryDateTime" = var.discovery_date_time
    "name"              = var.name
    "objects"           = (var.objects == null ? null : [for item0 in var.objects : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "attributes" = (item0["attributes"] == null ? null : [for item2 in item0["attributes"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "anchor" = item2["anchor"], "apiExpressions" = (item2["apiExpressions"] == null ? null : [for item4 in item2["apiExpressions"] : item4 if item4 != null]), "caseExact" = item2["caseExact"], "defaultValue" = item2["defaultValue"], "flowNullValues" = item2["flowNullValues"], "metadata" = (item2["metadata"] == null ? null : [for item4 in item2["metadata"] : item4 if item4 != null]), "multivalued" = item2["multivalued"], "mutability" = item2["mutability"], "name" = item2["name"], "referencedObjects" = (item2["referencedObjects"] == null ? null : [for item4 in item2["referencedObjects"] : item4 if item4 != null]), "required" = item2["required"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]), "metadata" = (item0["metadata"] == null ? null : [for item2 in item0["metadata"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "key" = item2["key"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "name" = item0["name"], "supportedApis" = (item0["supportedApis"] == null ? null : [for item2 in item0["supportedApis"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"       = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "applications/${urlencode(var.application_id)}/synchronization/templates/${urlencode(var.synchronization_template_id)}/schema/directories"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
