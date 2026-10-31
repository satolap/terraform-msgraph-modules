# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"          = var.odata_type
    "inboundAccess"        = (var.inboundAccess == null ? null : { for key0, value0 in { "@odata.type" = var.inboundAccess["odata_type"], "isAllowed" = var.inboundAccess["isAllowed"], "resourceScopes" = (var.inboundAccess["resourceScopes"] == null ? null : { for key1, value1 in { "@odata.type" = var.inboundAccess["resourceScopes"]["odata_type"], "excluded" = (var.inboundAccess["resourceScopes"]["excluded"] == null ? null : [for item2 in var.inboundAccess["resourceScopes"]["excluded"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "resourceId" = item2["resourceId"], "resourceType" = item2["resourceType"] } : key3 => value3 if value3 != null }) if item2 != null]), "included" = (var.inboundAccess["resourceScopes"]["included"] == null ? null : [for item2 in var.inboundAccess["resourceScopes"]["included"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "resourceId" = item2["resourceId"], "resourceType" = item2["resourceType"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "lastModifiedDateTime" = var.lastModifiedDateTime
    "name"                 = var.name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "policies/crossTenantAccessPolicy/partners/${urlencode(var.crossTenantAccessPolicyConfigurationPartner-tenantId)}/m365Capabilities"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

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
