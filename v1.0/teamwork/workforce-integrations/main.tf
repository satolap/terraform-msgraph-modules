# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "apiVersion"                          = var.api_version
    "createdBy"                           = var.created_by
    "displayName"                         = var.display_name
    "eligibilityFilteringEnabledEntities" = var.eligibility_filtering_enabled_entities
    "encryption"                          = (var.encryption == null ? null : { for key0, value0 in { "@odata.type" = var.encryption["odata_type"], "protocol" = var.encryption["protocol"], "secret" = var.encryption["secret"] } : key0 => value0 if value0 != null })
    "isActive"                            = var.is_active
    "@odata.type"                         = var.odata_type
    "supportedEntities"                   = var.supported_entities
    "url"                                 = var.url
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "teamwork/workforceIntegrations"
  api_version             = "v1.0"
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
