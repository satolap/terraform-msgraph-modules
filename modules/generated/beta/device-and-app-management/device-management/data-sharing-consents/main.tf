# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "grantDateTime"      = var.grant_date_time
    "granted"            = var.granted
    "grantedByUpn"       = var.granted_by_upn
    "grantedByUserId"    = var.granted_by_user_id
    "@odata.type"        = var.odata_type
    "serviceDisplayName" = var.service_display_name
    "termsUrl"           = var.terms_url
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/dataSharingConsents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
