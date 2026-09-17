# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"     = var.description
    "displayName"     = var.display_name
    "howToPrevent"    = var.how_to_prevent
    "isConfigurable"  = var.is_configurable
    "isRemediatable"  = var.is_remediatable
    "mitigationSteps" = var.mitigation_steps
    "@odata.type"     = var.odata_type
    "scopeId"         = var.scope_id
    "scopeType"       = var.scope_type
    "securityImpact"  = var.security_impact
    "severityLevel"   = var.severity_level
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/roleManagementAlerts/alertDefinitions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
