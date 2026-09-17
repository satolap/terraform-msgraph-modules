# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "certificate"                       = var.certificate
    "certificateAuthorityType"          = var.certificate_authority_type
    "certificateRevocationListUrl"      = var.certificate_revocation_list_url
    "createdDateTime"                   = var.created_date_time
    "deletedDateTime"                   = var.deleted_date_time
    "deltaCertificateRevocationListUrl" = var.delta_certificate_revocation_list_url
    "displayName"                       = var.display_name
    "expirationDateTime"                = var.expiration_date_time
    "isIssuerHintEnabled"               = var.is_issuer_hint_enabled
    "issuer"                            = var.issuer
    "issuerSubjectKeyIdentifier"        = var.issuer_subject_key_identifier
    "@odata.type"                       = var.odata_type
    "thumbprint"                        = var.thumbprint
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/${urlencode(var.certificate_based_auth_pki_id)}/certificateAuthorities"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
