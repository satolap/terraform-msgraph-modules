# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime"     = var.created_date_time
    "multiFactorSignIns"  = var.multi_factor_sign_ins
    "@odata.type"         = var.odata_type
    "singleFactorSignIns" = var.single_factor_sign_ins
    "totalSignIns"        = var.total_sign_ins
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "reports/authenticationMethods/userMfaSignInSummary"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
