# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "authMethods"       = (var.auth_methods == null ? null : [for item0 in var.auth_methods : item0 if item0 != null])
    "isCapable"         = var.is_capable
    "isEnabled"         = var.is_enabled
    "isMfaRegistered"   = var.is_mfa_registered
    "isRegistered"      = var.is_registered
    "@odata.type"       = var.odata_type
    "userDisplayName"   = var.user_display_name
    "userPrincipalName" = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "reports/credentialUserRegistrationDetails"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
