# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "defaultMfaMethod"                              = var.default_mfa_method
    "isAdmin"                                       = var.is_admin
    "isMfaCapable"                                  = var.is_mfa_capable
    "isMfaRegistered"                               = var.is_mfa_registered
    "isPasswordlessCapable"                         = var.is_passwordless_capable
    "isSsprCapable"                                 = var.is_sspr_capable
    "isSsprEnabled"                                 = var.is_sspr_enabled
    "isSsprRegistered"                              = var.is_sspr_registered
    "isSystemPreferredAuthenticationMethodEnabled"  = var.is_system_preferred_authentication_method_enabled
    "lastUpdatedDateTime"                           = var.last_updated_date_time
    "methodsRegistered"                             = (var.methods_registered == null ? null : [for item0 in var.methods_registered : item0 if item0 != null])
    "@odata.type"                                   = var.odata_type
    "systemPreferredAuthenticationMethods"          = (var.system_preferred_authentication_methods == null ? null : [for item0 in var.system_preferred_authentication_methods : item0 if item0 != null])
    "userDisplayName"                               = var.user_display_name
    "userPreferredMethodForSecondaryAuthentication" = var.user_preferred_method_for_secondary_authentication
    "userPrincipalName"                             = var.user_principal_name
    "userType"                                      = var.user_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "reports/authenticationMethods/userRegistrationDetails"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
