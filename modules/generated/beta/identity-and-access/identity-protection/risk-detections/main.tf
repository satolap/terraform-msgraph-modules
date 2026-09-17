# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activity"            = var.activity
    "activityDateTime"    = var.activity_date_time
    "additionalInfo"      = var.additional_info
    "correlationId"       = var.correlation_id
    "detectedDateTime"    = var.detected_date_time
    "detectionTimingType" = var.detection_timing_type
    "source"              = var.graph_source
    "ipAddress"           = var.ip_address
    "lastUpdatedDateTime" = var.last_updated_date_time
    "location"            = var.location
    "mitreTechniqueId"    = var.mitre_technique_id
    "@odata.type"         = var.odata_type
    "requestId"           = var.request_id
    "riskDetail"          = var.risk_detail
    "riskEventType"       = var.risk_event_type
    "riskLevel"           = var.risk_level
    "riskState"           = var.risk_state
    "riskType"            = var.risk_type
    "tokenIssuerType"     = var.token_issuer_type
    "userDisplayName"     = var.user_display_name
    "userId"              = var.user_id
    "userPrincipalName"   = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityProtection/riskDetections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
