# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "apiConnectorConfiguration" = (var.api_connector_configuration == null ? null : { for key0, value0 in { "@odata.type" = var.api_connector_configuration["odata_type"], "postAttributeCollection" = var.api_connector_configuration["postAttributeCollection"], "postFederationSignup" = var.api_connector_configuration["postFederationSignup"], "preTokenIssuance" = var.api_connector_configuration["preTokenIssuance"] } : key0 => value0 if value0 != null })
    "identityProviders"         = (var.identity_providers == null ? null : [for item0 in var.identity_providers : item0 if item0 != null])
    "languages"                 = (var.languages == null ? null : [for item0 in var.languages : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "defaultPages" = (item0["defaultPages"] == null ? null : [for item2 in item0["defaultPages"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"] } : key3 => value3 if value3 != null }) if item2 != null]), "isEnabled" = item0["isEnabled"], "overridesPages" = (item0["overridesPages"] == null ? null : [for item2 in item0["overridesPages"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"               = var.odata_type
    "userAttributeAssignments"  = (var.user_attribute_assignments == null ? null : [for item0 in var.user_attribute_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "isOptional" = item0["isOptional"], "requiresVerification" = item0["requiresVerification"], "userAttribute" = item0["userAttribute"], "userAttributeValues" = (item0["userAttributeValues"] == null ? null : [for item2 in item0["userAttributeValues"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "isDefault" = item2["isDefault"], "name" = item2["name"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "userInputType" = item0["userInputType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "userFlowIdentityProviders" = (var.user_flow_identity_providers == null ? null : [for item0 in var.user_flow_identity_providers : item0 if item0 != null])
    "userFlowType"              = var.user_flow_type
    "userFlowTypeVersion"       = var.user_flow_type_version
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identity/b2xUserFlows"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
