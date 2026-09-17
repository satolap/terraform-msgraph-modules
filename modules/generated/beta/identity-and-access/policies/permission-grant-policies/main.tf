# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deletedDateTime"                   = var.deleted_date_time
    "description"                       = var.description
    "displayName"                       = var.display_name
    "excludes"                          = (var.excludes == null ? null : [for item0 in var.excludes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "certifiedClientApplicationsOnly" = item0["certifiedClientApplicationsOnly"], "clientApplicationIds" = (item0["clientApplicationIds"] == null ? null : [for item2 in item0["clientApplicationIds"] : item2 if item2 != null]), "clientApplicationPublisherIds" = (item0["clientApplicationPublisherIds"] == null ? null : [for item2 in item0["clientApplicationPublisherIds"] : item2 if item2 != null]), "clientApplicationTenantIds" = (item0["clientApplicationTenantIds"] == null ? null : [for item2 in item0["clientApplicationTenantIds"] : item2 if item2 != null]), "clientApplicationsFromVerifiedPublisherOnly" = item0["clientApplicationsFromVerifiedPublisherOnly"], "permissionClassification" = item0["permissionClassification"], "permissionType" = item0["permissionType"], "permissions" = (item0["permissions"] == null ? null : [for item2 in item0["permissions"] : item2 if item2 != null]), "resourceApplication" = item0["resourceApplication"], "scopeSensitivityLabels" = (item0["scopeSensitivityLabels"] == null ? null : { for key2, value2 in { "@odata.type" = item0["scopeSensitivityLabels"]["odata_type"], "labelKind" = item0["scopeSensitivityLabels"]["labelKind"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "includeAllPreApprovedApplications" = var.include_all_pre_approved_applications
    "includes"                          = (var.includes == null ? null : [for item0 in var.includes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "certifiedClientApplicationsOnly" = item0["certifiedClientApplicationsOnly"], "clientApplicationIds" = (item0["clientApplicationIds"] == null ? null : [for item2 in item0["clientApplicationIds"] : item2 if item2 != null]), "clientApplicationPublisherIds" = (item0["clientApplicationPublisherIds"] == null ? null : [for item2 in item0["clientApplicationPublisherIds"] : item2 if item2 != null]), "clientApplicationTenantIds" = (item0["clientApplicationTenantIds"] == null ? null : [for item2 in item0["clientApplicationTenantIds"] : item2 if item2 != null]), "clientApplicationsFromVerifiedPublisherOnly" = item0["clientApplicationsFromVerifiedPublisherOnly"], "permissionClassification" = item0["permissionClassification"], "permissionType" = item0["permissionType"], "permissions" = (item0["permissions"] == null ? null : [for item2 in item0["permissions"] : item2 if item2 != null]), "resourceApplication" = item0["resourceApplication"], "scopeSensitivityLabels" = (item0["scopeSensitivityLabels"] == null ? null : { for key2, value2 in { "@odata.type" = item0["scopeSensitivityLabels"]["odata_type"], "labelKind" = item0["scopeSensitivityLabels"]["labelKind"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                       = var.odata_type
    "resourceScopeType"                 = var.resource_scope_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "policies/permissionGrantPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
