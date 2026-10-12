# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "arity"                     = var.arity
    "multivaluedComparisonType" = var.multivalued_comparison_type
    "@odata.type"               = var.odata_type
    "supportedAttributeTypes"   = (var.supported_attribute_types == null ? null : [for item0 in var.supported_attribute_types : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "filterOperators"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
