# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activeSignInUri"                        = var.activeSignInUri
    "defaultInteractiveAuthenticationMethod" = var.defaultInteractiveAuthenticationMethod
    "displayName"                            = var.displayName
    "federatedIdpMfaBehavior"                = var.federatedIdpMfaBehavior
    "isSignedAuthenticationRequestRequired"  = var.isSignedAuthenticationRequestRequired
    "issuerUri"                              = var.issuerUri
    "metadataExchangeUri"                    = var.metadataExchangeUri
    "nextSigningCertificate"                 = var.nextSigningCertificate
    "@odata.type"                            = var.odata_type
    "openIdConnectDiscoveryEndpoint"         = var.openIdConnectDiscoveryEndpoint
    "passiveSignInUri"                       = var.passiveSignInUri
    "passwordChangeUri"                      = var.passwordChangeUri
    "passwordResetUri"                       = var.passwordResetUri
    "preferredAuthenticationProtocol"        = var.preferredAuthenticationProtocol
    "promptLoginBehavior"                    = var.promptLoginBehavior
    "signOutUri"                             = var.signOutUri
    "signingCertificate"                     = var.signingCertificate
    "signingCertificateUpdateStatus"         = (var.signingCertificateUpdateStatus == null ? null : { for key0, value0 in { "@odata.type" = var.signingCertificateUpdateStatus["odata_type"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "domains/${urlencode(var.domain-id)}/federationConfiguration"
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
