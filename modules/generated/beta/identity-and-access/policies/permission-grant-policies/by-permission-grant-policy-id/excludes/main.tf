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
    "scopeSensitivityLabels"                      = (var.scope_sensitivity_labels == null ? null : { for key0, value0 in { "@odata.type" = var.scope_sensitivity_labels["odata_type"], "labelKind" = var.scope_sensitivity_labels["labelKind"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "policies/permissionGrantPolicies/${urlencode(var.permission_grant_policy_id)}/excludes"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
