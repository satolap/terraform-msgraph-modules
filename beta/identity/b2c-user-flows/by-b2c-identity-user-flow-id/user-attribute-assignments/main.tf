# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"          = var.display_name
    "isOptional"           = var.is_optional
    "@odata.type"          = var.odata_type
    "requiresVerification" = var.requires_verification
    "userAttribute"        = var.user_attribute
    "userAttributeValues"  = (var.user_attribute_values == null ? null : [for item0 in var.user_attribute_values : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isDefault" = item0["isDefault"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "userInputType"        = var.user_input_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identity/b2cUserFlows/${urlencode(var.b2c_identity_user_flow_id)}/userAttributeAssignments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
