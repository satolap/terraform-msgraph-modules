# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activeSignInUri"                       = var.active_sign_in_uri
    "displayName"                           = var.display_name
    "federatedIdpMfaBehavior"               = var.federated_idp_mfa_behavior
    "isSignedAuthenticationRequestRequired" = var.is_signed_authentication_request_required
    "issuerUri"                             = var.issuer_uri
    "metadataExchangeUri"                   = var.metadata_exchange_uri
    "nextSigningCertificate"                = var.next_signing_certificate
    "@odata.type"                           = var.odata_type
    "passiveSignInUri"                      = var.passive_sign_in_uri
    "passwordResetUri"                      = var.password_reset_uri
    "preferredAuthenticationProtocol"       = var.preferred_authentication_protocol
    "promptLoginBehavior"                   = var.prompt_login_behavior
    "signOutUri"                            = var.sign_out_uri
    "signingCertificate"                    = var.signing_certificate
    "signingCertificateUpdateStatus"        = var.signing_certificate_update_status
    "systemBrowserEnabledOn"                = var.system_browser_enabled_on
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "domains/${urlencode(var.domain_id)}/federationConfiguration"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
