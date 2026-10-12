# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deletedDateTime" = var.deleted_date_time
    "description"     = var.description
    "displayName"     = var.display_name
    "excludes"        = (var.excludes == null ? null : [for item0 in var.excludes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "applicationIds" = (item0["applicationIds"] == null ? null : [for item2 in item0["applicationIds"] : item2 if item2 != null]), "applicationPublisherIds" = (item0["applicationPublisherIds"] == null ? null : [for item2 in item0["applicationPublisherIds"] : item2 if item2 != null]), "applicationTenantIds" = (item0["applicationTenantIds"] == null ? null : [for item2 in item0["applicationTenantIds"] : item2 if item2 != null]), "applicationsFromVerifiedPublisherOnly" = item0["applicationsFromVerifiedPublisherOnly"], "certifiedApplicationsOnly" = item0["certifiedApplicationsOnly"] } : key1 => value1 if value1 != null }) if item0 != null])
    "includes"        = (var.includes == null ? null : [for item0 in var.includes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "applicationIds" = (item0["applicationIds"] == null ? null : [for item2 in item0["applicationIds"] : item2 if item2 != null]), "applicationPublisherIds" = (item0["applicationPublisherIds"] == null ? null : [for item2 in item0["applicationPublisherIds"] : item2 if item2 != null]), "applicationTenantIds" = (item0["applicationTenantIds"] == null ? null : [for item2 in item0["applicationTenantIds"] : item2 if item2 != null]), "applicationsFromVerifiedPublisherOnly" = item0["applicationsFromVerifiedPublisherOnly"], "certifiedApplicationsOnly" = item0["certifiedApplicationsOnly"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isBuiltIn"       = var.is_built_in
    "@odata.type"     = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "policies/servicePrincipalCreationPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
