# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime"     = var.created_date_time
    "expirationDateTime"  = var.expiration_date_time
    "governedTenantId"    = var.governed_tenant_id
    "governedTenantName"  = var.governed_tenant_name
    "governingTenantId"   = var.governing_tenant_id
    "governingTenantName" = var.governing_tenant_name
    "@odata.type"         = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/tenantGovernance/governanceInvitations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
