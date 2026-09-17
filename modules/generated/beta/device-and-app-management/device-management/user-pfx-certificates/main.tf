# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime"      = var.created_date_time
    "encryptedPfxBlob"     = var.encrypted_pfx_blob
    "encryptedPfxPassword" = var.encrypted_pfx_password
    "expirationDateTime"   = var.expiration_date_time
    "intendedPurpose"      = var.intended_purpose
    "keyName"              = var.key_name
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "paddingScheme"        = var.padding_scheme
    "providerName"         = var.provider_name
    "startDateTime"        = var.start_date_time
    "thumbprint"           = var.thumbprint
    "userPrincipalName"    = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/userPfxCertificates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
