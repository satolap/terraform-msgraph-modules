# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activeSignInUri"                        = var.active_sign_in_uri
    "defaultInteractiveAuthenticationMethod" = var.default_interactive_authentication_method
    "displayName"                            = var.display_name
    "federatedIdpMfaBehavior"                = var.federated_idp_mfa_behavior
    "isSignedAuthenticationRequestRequired"  = var.is_signed_authentication_request_required
    "issuerUri"                              = var.issuer_uri
    "metadataExchangeUri"                    = var.metadata_exchange_uri
    "nextSigningCertificate"                 = var.next_signing_certificate
    "@odata.type"                            = var.odata_type
    "openIdConnectDiscoveryEndpoint"         = var.open_id_connect_discovery_endpoint
    "passiveSignInUri"                       = var.passive_sign_in_uri
    "passwordChangeUri"                      = var.password_change_uri
    "passwordResetUri"                       = var.password_reset_uri
    "preferredAuthenticationProtocol"        = var.preferred_authentication_protocol
    "promptLoginBehavior"                    = var.prompt_login_behavior
    "signOutUri"                             = var.sign_out_uri
    "signingCertificate"                     = var.signing_certificate
    "signingCertificateUpdateStatus"         = (var.signing_certificate_update_status == null ? null : { for key0, value0 in { "@odata.type" = var.signing_certificate_update_status["odata_type"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "domains/${urlencode(var.domain_id)}/federationConfiguration"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
