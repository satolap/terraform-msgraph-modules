# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "certificateAuthorities" = (var.certificate_authorities == null ? null : [for item0 in var.certificate_authorities : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "certificate" = item0["certificate"], "certificateRevocationListUrl" = item0["certificateRevocationListUrl"], "deltaCertificateRevocationListUrl" = item0["deltaCertificateRevocationListUrl"], "isRootAuthority" = item0["isRootAuthority"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"            = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "certificateBasedAuthConfiguration"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
