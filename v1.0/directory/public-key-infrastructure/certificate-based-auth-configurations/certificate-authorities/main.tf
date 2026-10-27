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

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/${urlencode(var.certificate_based_auth_pki_id)}/certificateAuthorities"
  api_version             = "v1.0"
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
