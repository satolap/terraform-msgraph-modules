# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "applicationIds"                        = (var.application_ids == null ? null : [for item0 in var.application_ids : item0 if item0 != null])
    "applicationPublisherIds"               = (var.application_publisher_ids == null ? null : [for item0 in var.application_publisher_ids : item0 if item0 != null])
    "applicationTenantIds"                  = (var.application_tenant_ids == null ? null : [for item0 in var.application_tenant_ids : item0 if item0 != null])
    "applicationsFromVerifiedPublisherOnly" = var.applications_from_verified_publisher_only
    "certifiedApplicationsOnly"             = var.certified_applications_only
    "@odata.type"                           = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "policies/servicePrincipalCreationPolicies/${urlencode(var.service_principal_creation_policy_id)}/includes"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
