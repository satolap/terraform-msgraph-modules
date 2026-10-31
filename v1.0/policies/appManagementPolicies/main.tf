# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appliesTo"       = (var.appliesTo == null ? null : [for item0 in var.appliesTo : item0 if item0 != null])
    "deletedDateTime" = var.deletedDateTime
    "description"     = var.description
    "displayName"     = var.displayName
    "isEnabled"       = var.isEnabled
    "@odata.type"     = var.odata_type
    "restrictions"    = (var.restrictions == null ? null : { for key0, value0 in { "@odata.type" = var.restrictions["odata_type"], "applicationRestrictions" = (var.restrictions["applicationRestrictions"] == null ? null : { for key1, value1 in { "@odata.type" = var.restrictions["applicationRestrictions"]["odata_type"], "identifierUris" = (var.restrictions["applicationRestrictions"]["identifierUris"] == null ? null : { for key2, value2 in { "@odata.type" = var.restrictions["applicationRestrictions"]["identifierUris"]["odata_type"], "nonDefaultUriAddition" = (var.restrictions["applicationRestrictions"]["identifierUris"]["nonDefaultUriAddition"] == null ? null : { for key3, value3 in { "@odata.type" = var.restrictions["applicationRestrictions"]["identifierUris"]["nonDefaultUriAddition"]["odata_type"], "excludeActors" = (var.restrictions["applicationRestrictions"]["identifierUris"]["nonDefaultUriAddition"]["excludeActors"] == null ? null : { for key4, value4 in { "@odata.type" = var.restrictions["applicationRestrictions"]["identifierUris"]["nonDefaultUriAddition"]["excludeActors"]["odata_type"], "customSecurityAttributes" = var.restrictions["applicationRestrictions"]["identifierUris"]["nonDefaultUriAddition"]["excludeActors"]["customSecurityAttributes"] } : key4 => value4 if value4 != null }), "excludeAppsReceivingV2Tokens" = var.restrictions["applicationRestrictions"]["identifierUris"]["nonDefaultUriAddition"]["excludeAppsReceivingV2Tokens"], "excludeSaml" = var.restrictions["applicationRestrictions"]["identifierUris"]["nonDefaultUriAddition"]["excludeSaml"], "restrictForAppsCreatedAfterDateTime" = var.restrictions["applicationRestrictions"]["identifierUris"]["nonDefaultUriAddition"]["restrictForAppsCreatedAfterDateTime"], "state" = var.restrictions["applicationRestrictions"]["identifierUris"]["nonDefaultUriAddition"]["state"] } : key3 => value3 if value3 != null }), "uriAdditionWithoutUniqueTenantIdentifier" = (var.restrictions["applicationRestrictions"]["identifierUris"]["uriAdditionWithoutUniqueTenantIdentifier"] == null ? null : { for key3, value3 in { "@odata.type" = var.restrictions["applicationRestrictions"]["identifierUris"]["uriAdditionWithoutUniqueTenantIdentifier"]["odata_type"], "excludeActors" = (var.restrictions["applicationRestrictions"]["identifierUris"]["uriAdditionWithoutUniqueTenantIdentifier"]["excludeActors"] == null ? null : { for key4, value4 in { "@odata.type" = var.restrictions["applicationRestrictions"]["identifierUris"]["uriAdditionWithoutUniqueTenantIdentifier"]["excludeActors"]["odata_type"], "customSecurityAttributes" = var.restrictions["applicationRestrictions"]["identifierUris"]["uriAdditionWithoutUniqueTenantIdentifier"]["excludeActors"]["customSecurityAttributes"] } : key4 => value4 if value4 != null }), "excludeAppsReceivingV2Tokens" = var.restrictions["applicationRestrictions"]["identifierUris"]["uriAdditionWithoutUniqueTenantIdentifier"]["excludeAppsReceivingV2Tokens"], "excludeSaml" = var.restrictions["applicationRestrictions"]["identifierUris"]["uriAdditionWithoutUniqueTenantIdentifier"]["excludeSaml"], "restrictForAppsCreatedAfterDateTime" = var.restrictions["applicationRestrictions"]["identifierUris"]["uriAdditionWithoutUniqueTenantIdentifier"]["restrictForAppsCreatedAfterDateTime"], "state" = var.restrictions["applicationRestrictions"]["identifierUris"]["uriAdditionWithoutUniqueTenantIdentifier"]["state"] } : key3 => value3 if value3 != null }) } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }), "keyCredentials" = (var.restrictions["keyCredentials"] == null ? null : [for item1 in var.restrictions["keyCredentials"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "excludeActors" = (item1["excludeActors"] == null ? null : { for key3, value3 in { "@odata.type" = item1["excludeActors"]["odata_type"], "customSecurityAttributes" = (item1["excludeActors"]["customSecurityAttributes"] == null ? null : [for item4 in item1["excludeActors"]["customSecurityAttributes"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }), "maxLifetime" = item1["maxLifetime"], "restrictForAppsCreatedAfterDateTime" = item1["restrictForAppsCreatedAfterDateTime"], "restrictionType" = item1["restrictionType"], "state" = item1["state"] } : key2 => value2 if value2 != null }) if item1 != null]), "passwordCredentials" = (var.restrictions["passwordCredentials"] == null ? null : [for item1 in var.restrictions["passwordCredentials"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "excludeActors" = (item1["excludeActors"] == null ? null : { for key3, value3 in { "@odata.type" = item1["excludeActors"]["odata_type"], "customSecurityAttributes" = (item1["excludeActors"]["customSecurityAttributes"] == null ? null : [for item4 in item1["excludeActors"]["customSecurityAttributes"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }), "maxLifetime" = item1["maxLifetime"], "restrictForAppsCreatedAfterDateTime" = item1["restrictForAppsCreatedAfterDateTime"], "restrictionType" = item1["restrictionType"], "state" = item1["state"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "policies/appManagementPolicies"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["appliesTo"], name)])]))))] } : null

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
