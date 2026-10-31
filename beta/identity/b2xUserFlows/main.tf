# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "apiConnectorConfiguration" = (var.apiConnectorConfiguration == null ? null : { for key0, value0 in { "@odata.type" = var.apiConnectorConfiguration["odata_type"], "postAttributeCollection" = var.apiConnectorConfiguration["postAttributeCollection"], "postFederationSignup" = var.apiConnectorConfiguration["postFederationSignup"], "preTokenIssuance" = var.apiConnectorConfiguration["preTokenIssuance"] } : key0 => value0 if value0 != null })
    "identityProviders"         = (var.identityProviders == null ? null : [for item0 in var.identityProviders : item0 if item0 != null])
    "languages"                 = (var.languages == null ? null : [for item0 in var.languages : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "defaultPages" = (item0["defaultPages"] == null ? null : [for item2 in item0["defaultPages"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"] } : key3 => value3 if value3 != null }) if item2 != null]), "isEnabled" = item0["isEnabled"], "overridesPages" = (item0["overridesPages"] == null ? null : [for item2 in item0["overridesPages"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"               = var.odata_type
    "userAttributeAssignments"  = (var.userAttributeAssignments == null ? null : [for item0 in var.userAttributeAssignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "isOptional" = item0["isOptional"], "requiresVerification" = item0["requiresVerification"], "userAttribute" = item0["userAttribute"], "userAttributeValues" = (item0["userAttributeValues"] == null ? null : [for item2 in item0["userAttributeValues"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "isDefault" = item2["isDefault"], "name" = item2["name"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "userInputType" = item0["userInputType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "userFlowIdentityProviders" = (var.userFlowIdentityProviders == null ? null : [for item0 in var.userFlowIdentityProviders : item0 if item0 != null])
    "userFlowType"              = var.userFlowType
    "userFlowTypeVersion"       = var.userFlowTypeVersion
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "identity/b2xUserFlows"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["identityProviders", "languages", "userAttributeAssignments", "userFlowIdentityProviders"], name)])]))))] } : null

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
