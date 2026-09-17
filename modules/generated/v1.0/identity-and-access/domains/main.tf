# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "authenticationType"               = var.authentication_type
    "availabilityStatus"               = var.availability_status
    "federationConfiguration"          = (var.federation_configuration == null ? null : [for item0 in var.federation_configuration : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "activeSignInUri" = item0["activeSignInUri"], "displayName" = item0["displayName"], "federatedIdpMfaBehavior" = item0["federatedIdpMfaBehavior"], "isSignedAuthenticationRequestRequired" = item0["isSignedAuthenticationRequestRequired"], "issuerUri" = item0["issuerUri"], "metadataExchangeUri" = item0["metadataExchangeUri"], "nextSigningCertificate" = item0["nextSigningCertificate"], "passiveSignInUri" = item0["passiveSignInUri"], "passwordResetUri" = item0["passwordResetUri"], "preferredAuthenticationProtocol" = item0["preferredAuthenticationProtocol"], "promptLoginBehavior" = item0["promptLoginBehavior"], "signOutUri" = item0["signOutUri"], "signingCertificate" = item0["signingCertificate"], "signingCertificateUpdateStatus" = item0["signingCertificateUpdateStatus"], "systemBrowserEnabledOn" = item0["systemBrowserEnabledOn"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isAdminManaged"                   = var.is_admin_managed
    "isDefault"                        = var.is_default
    "isInitial"                        = var.is_initial
    "isRoot"                           = var.is_root
    "isVerified"                       = var.is_verified
    "manufacturer"                     = var.manufacturer
    "model"                            = var.model
    "@odata.type"                      = var.odata_type
    "passwordNotificationWindowInDays" = var.password_notification_window_in_days
    "passwordValidityPeriodInDays"     = var.password_validity_period_in_days
    "state"                            = var.state
    "supportedServices"                = (var.supported_services == null ? null : [for item0 in var.supported_services : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "domains"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
