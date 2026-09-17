# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appB2BSignInActivityMetrics"   = var.app_b2_b_sign_in_activity_metrics
    "b2BRegistrationMetrics"        = var.b2_b_registration_metrics
    "b2BSignInActivityMetrics"      = var.b2_b_sign_in_activity_metrics
    "billingMetrics"                = var.billing_metrics
    "createdDateTime"               = var.created_date_time
    "multiTenantApplicationMetrics" = var.multi_tenant_application_metrics
    "@odata.type"                   = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/tenantGovernance/relatedTenants"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
