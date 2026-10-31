# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "certifiedClientApplicationsOnly"             = var.certifiedClientApplicationsOnly
    "clientApplicationIds"                        = (var.clientApplicationIds == null ? null : [for item0 in var.clientApplicationIds : item0 if item0 != null])
    "clientApplicationPublisherIds"               = (var.clientApplicationPublisherIds == null ? null : [for item0 in var.clientApplicationPublisherIds : item0 if item0 != null])
    "clientApplicationTenantIds"                  = (var.clientApplicationTenantIds == null ? null : [for item0 in var.clientApplicationTenantIds : item0 if item0 != null])
    "clientApplicationsFromVerifiedPublisherOnly" = var.clientApplicationsFromVerifiedPublisherOnly
    "@odata.type"                                 = var.odata_type
    "permissionClassification"                    = var.permissionClassification
    "permissionType"                              = var.permissionType
    "permissions"                                 = (var.permissions == null ? null : [for item0 in var.permissions : item0 if item0 != null])
    "resourceApplication"                         = var.resourceApplication
    "scopeSensitivityLabels"                      = var.scopeSensitivityLabels
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "policies/permissionGrantPolicies/${urlencode(var.permissionGrantPolicy-id)}/excludes"
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
