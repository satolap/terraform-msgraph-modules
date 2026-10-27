# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"      = var.description
    "displayName"      = var.display_name
    "externalSponsors" = (var.external_sponsors == null ? null : [for item0 in var.external_sponsors : item0 if item0 != null])
    "identitySources"  = (var.identity_sources == null ? null : [for item0 in var.identity_sources : item0 if item0 != null])
    "internalSponsors" = (var.internal_sponsors == null ? null : [for item0 in var.internal_sponsors : item0 if item0 != null])
    "@odata.type"      = var.odata_type
    "state"            = var.state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/connectedOrganizations"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["externalSponsors", "internalSponsors"], name)])]))))] } : null

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
