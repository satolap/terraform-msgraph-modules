# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "agentDisplayName"         = var.agent_display_name
    "blueprintId"              = var.blueprint_id
    "identityType"             = var.identity_type
    "isDeleted"                = var.is_deleted
    "isEnabled"                = var.is_enabled
    "isProcessing"             = var.is_processing
    "@odata.type"              = var.odata_type
    "riskDetail"               = var.risk_detail
    "riskLastModifiedDateTime" = var.risk_last_modified_date_time
    "riskLevel"                = var.risk_level
    "riskState"                = var.risk_state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityProtection/riskyAgents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
