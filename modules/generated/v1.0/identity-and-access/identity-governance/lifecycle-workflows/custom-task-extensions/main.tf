# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "authenticationConfiguration" = var.authentication_configuration
    "callbackConfiguration"       = var.callback_configuration
    "clientConfiguration"         = var.client_configuration
    "createdBy"                   = var.created_by
    "createdDateTime"             = var.created_date_time
    "description"                 = var.description
    "displayName"                 = var.display_name
    "endpointConfiguration"       = var.endpoint_configuration
    "lastModifiedBy"              = var.last_modified_by
    "lastModifiedDateTime"        = var.last_modified_date_time
    "@odata.type"                 = var.odata_type
    "replyMode"                   = var.reply_mode
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/lifecycleWorkflows/customTaskExtensions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
