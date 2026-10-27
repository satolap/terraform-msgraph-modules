# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "certifiedClientApplicationsOnly"             = var.certified_client_applications_only
    "clientApplicationIds"                        = (var.client_application_ids == null ? null : [for item0 in var.client_application_ids : item0 if item0 != null])
    "clientApplicationPublisherIds"               = (var.client_application_publisher_ids == null ? null : [for item0 in var.client_application_publisher_ids : item0 if item0 != null])
    "clientApplicationTenantIds"                  = (var.client_application_tenant_ids == null ? null : [for item0 in var.client_application_tenant_ids : item0 if item0 != null])
    "clientApplicationsFromVerifiedPublisherOnly" = var.client_applications_from_verified_publisher_only
    "@odata.type"                                 = var.odata_type
    "permissionClassification"                    = var.permission_classification
    "permissionType"                              = var.permission_type
    "permissions"                                 = (var.permissions == null ? null : [for item0 in var.permissions : item0 if item0 != null])
    "resourceApplication"                         = var.resource_application
    "scopeSensitivityLabels"                      = var.scope_sensitivity_labels
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "policies/permissionGrantPolicies/${urlencode(var.permission_grant_policy_id)}/excludes"
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
