# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "certificate"      = var.certificate
    "chain"            = var.chain
    "commonName"       = var.common_name
    "name"             = var.name
    "@odata.type"      = var.odata_type
    "organizationName" = var.organization_name
    "status"           = var.status
    "validity"         = (var.validity == null ? null : { for key0, value0 in { "@odata.type" = var.validity["odata_type"], "endDateTime" = var.validity["endDateTime"], "startDateTime" = var.validity["startDateTime"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "networkAccess/tls/externalCertificateAuthorityCertificates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
