# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"                = var.display_name
    "helpUrl"                    = var.help_url
    "issuer"                     = var.issuer
    "notificationType"           = var.notification_type
    "@odata.type"                = var.odata_type
    "renewalThresholdPercentage" = var.renewal_threshold_percentage
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/derivedCredentials"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
