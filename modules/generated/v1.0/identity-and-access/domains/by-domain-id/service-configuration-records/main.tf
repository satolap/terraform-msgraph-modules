# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "isOptional"       = var.is_optional
    "label"            = var.label
    "@odata.type"      = var.odata_type
    "recordType"       = var.record_type
    "supportedService" = var.supported_service
    "ttl"              = var.ttl
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "domains/${urlencode(var.domain_id)}/serviceConfigurationRecords"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
