# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deletedDateTime"                   = var.deletedDateTime
    "description"                       = var.description
    "displayName"                       = var.displayName
    "excludes"                          = (var.excludes == null ? null : [for item0 in var.excludes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "certifiedClientApplicationsOnly" = item0["certifiedClientApplicationsOnly"], "clientApplicationIds" = (item0["clientApplicationIds"] == null ? null : [for item2 in item0["clientApplicationIds"] : item2 if item2 != null]), "clientApplicationPublisherIds" = (item0["clientApplicationPublisherIds"] == null ? null : [for item2 in item0["clientApplicationPublisherIds"] : item2 if item2 != null]), "clientApplicationTenantIds" = (item0["clientApplicationTenantIds"] == null ? null : [for item2 in item0["clientApplicationTenantIds"] : item2 if item2 != null]), "clientApplicationsFromVerifiedPublisherOnly" = item0["clientApplicationsFromVerifiedPublisherOnly"], "permissionClassification" = item0["permissionClassification"], "permissionType" = item0["permissionType"], "permissions" = (item0["permissions"] == null ? null : [for item2 in item0["permissions"] : item2 if item2 != null]), "resourceApplication" = item0["resourceApplication"], "scopeSensitivityLabels" = item0["scopeSensitivityLabels"] } : key1 => value1 if value1 != null }) if item0 != null])
    "includeAllPreApprovedApplications" = var.includeAllPreApprovedApplications
    "includes"                          = (var.includes == null ? null : [for item0 in var.includes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "certifiedClientApplicationsOnly" = item0["certifiedClientApplicationsOnly"], "clientApplicationIds" = (item0["clientApplicationIds"] == null ? null : [for item2 in item0["clientApplicationIds"] : item2 if item2 != null]), "clientApplicationPublisherIds" = (item0["clientApplicationPublisherIds"] == null ? null : [for item2 in item0["clientApplicationPublisherIds"] : item2 if item2 != null]), "clientApplicationTenantIds" = (item0["clientApplicationTenantIds"] == null ? null : [for item2 in item0["clientApplicationTenantIds"] : item2 if item2 != null]), "clientApplicationsFromVerifiedPublisherOnly" = item0["clientApplicationsFromVerifiedPublisherOnly"], "permissionClassification" = item0["permissionClassification"], "permissionType" = item0["permissionType"], "permissions" = (item0["permissions"] == null ? null : [for item2 in item0["permissions"] : item2 if item2 != null]), "resourceApplication" = item0["resourceApplication"], "scopeSensitivityLabels" = item0["scopeSensitivityLabels"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                       = var.odata_type
    "resourceScopeType"                 = var.resourceScopeType
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "policies/permissionGrantPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["excludes", "includes"], name)])]))))] } : null

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
