# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deletedDateTime"               = var.deleted_date_time
    "description"                   = var.description
    "displayName"                   = var.display_name
    "@odata.type"                   = var.odata_type
    "trustedCertificateAuthorities" = (var.trusted_certificate_authorities == null ? null : [for item0 in var.trusted_certificate_authorities : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "certificate" = item0["certificate"], "isRootAuthority" = item0["isRootAuthority"], "issuer" = item0["issuer"], "issuerSubjectKeyIdentifier" = item0["issuerSubjectKeyIdentifier"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "certificateAuthorities/certificateBasedApplicationConfigurations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
