# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"       = var.odata_type
    "alertDefinition"   = var.alert_definition
    "alertDefinitionId" = var.alert_definition_id
    "isEnabled"         = var.is_enabled
    "scopeId"           = var.scope_id
    "scopeType"         = var.scope_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/roleManagementAlerts/alertConfigurations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
