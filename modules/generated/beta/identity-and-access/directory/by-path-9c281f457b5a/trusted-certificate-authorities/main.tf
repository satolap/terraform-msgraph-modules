# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "certificate"                = var.certificate
    "isRootAuthority"            = var.is_root_authority
    "issuer"                     = var.issuer
    "issuerSubjectKeyIdentifier" = var.issuer_subject_key_identifier
    "@odata.type"                = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/certificateAuthorities/certificateBasedApplicationConfigurations/${urlencode(var.certificate_based_application_configuration_id)}/trustedCertificateAuthorities"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
