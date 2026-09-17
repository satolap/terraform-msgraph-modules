# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedValues"           = (var.allowed_values == null ? null : [for item0 in var.allowed_values : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isActive" = item0["isActive"] } : key1 => value1 if value1 != null }) if item0 != null])
    "attributeSet"            = var.attribute_set
    "description"             = var.description
    "isCollection"            = var.is_collection
    "isSearchable"            = var.is_searchable
    "name"                    = var.name
    "@odata.type"             = var.odata_type
    "status"                  = var.status
    "type"                    = var.type
    "usePreDefinedValuesOnly" = var.use_pre_defined_values_only
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/customSecurityAttributeDefinitions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
