# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "capability"         = var.capability
    "deletedDateTime"    = var.deleted_date_time
    "@odata.type"        = var.odata_type
    "providerId"         = var.provider_id
    "providerName"       = var.provider_name
    "providerResourceId" = var.provider_resource_id
    "uri"                = var.uri
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "servicePrincipals/${urlencode(var.service_principal_id)}/endpoints"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
