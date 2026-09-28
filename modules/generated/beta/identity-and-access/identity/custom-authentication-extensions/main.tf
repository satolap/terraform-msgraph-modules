# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"                 = var.odata_type
    "authenticationConfiguration" = var.authentication_configuration
    "behaviorOnError"             = var.behavior_on_error
    "clientConfiguration"         = (var.client_configuration == null ? null : { for key0, value0 in { "@odata.type" = var.client_configuration["odata_type"], "maximumRetries" = var.client_configuration["maximumRetries"], "timeoutInMilliseconds" = var.client_configuration["timeoutInMilliseconds"] } : key0 => value0 if value0 != null })
    "description"                 = var.description
    "displayName"                 = var.display_name
    "endpointConfiguration"       = var.endpoint_configuration
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identity/customAuthenticationExtensions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
