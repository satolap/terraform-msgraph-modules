# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "authenticationConfiguration" = var.authentication_configuration
    "clientConfiguration"         = var.client_configuration
    "description"                 = var.description
    "displayName"                 = var.display_name
    "endpointConfiguration"       = var.endpoint_configuration
    "@odata.type"                 = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/resourceRequests/${urlencode(var.access_package_resource_request_id)}/catalog/customWorkflowExtensions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
