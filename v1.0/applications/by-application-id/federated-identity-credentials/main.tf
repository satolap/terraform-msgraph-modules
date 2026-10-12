# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "audiences"   = (var.audiences == null ? null : [for item0 in var.audiences : item0 if item0 != null])
    "description" = var.description
    "issuer"      = var.issuer
    "name"        = var.name
    "@odata.type" = var.odata_type
    "subject"     = var.subject
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "applications/${urlencode(var.application_id)}/federatedIdentityCredentials"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
