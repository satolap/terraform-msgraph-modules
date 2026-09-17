# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "content"            = var.content
    "expirationDateTime" = var.expiration_date_time
    "issuer"             = var.issuer
    "issuerName"         = var.issuer_name
    "@odata.type"        = var.odata_type
    "status"             = var.status
    "subject"            = var.subject
    "subjectName"        = var.subject_name
    "uploadDateTime"     = var.upload_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/enterpriseCodeSigningCertificates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
