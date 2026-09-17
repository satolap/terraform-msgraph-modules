# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appVersion"               = var.app_version
    "deviceHealth"             = var.device_health
    "displayName"              = var.display_name
    "fullyQualifiedDomainName" = var.fully_qualified_domain_name
    "location"                 = var.location
    "name"                     = var.name
    "@odata.type"              = var.odata_type
    "operatingSystem"          = var.operating_system
    "registeredDateTime"       = var.registered_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "print/connectors"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
