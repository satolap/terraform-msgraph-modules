# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "brand"                   = var.brand
    "complexity"              = var.complexity
    "createdBy"               = var.created_by
    "createdDateTime"         = var.created_date_time
    "description"             = var.description
    "detail"                  = var.detail
    "displayName"             = var.display_name
    "source"                  = var.graph_source
    "industry"                = var.industry
    "isAutomated"             = var.is_automated
    "isControversial"         = var.is_controversial
    "isCurrentEvent"          = var.is_current_event
    "language"                = var.language
    "lastModifiedBy"          = var.last_modified_by
    "lastModifiedDateTime"    = var.last_modified_date_time
    "@odata.type"             = var.odata_type
    "payloadTags"             = (var.payload_tags == null ? null : [for item0 in var.payload_tags : item0 if item0 != null])
    "platform"                = var.platform
    "predictedCompromiseRate" = var.predicted_compromise_rate
    "simulationAttackType"    = var.simulation_attack_type
    "status"                  = var.status
    "technique"               = var.technique
    "theme"                   = var.theme
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/attackSimulation/payloads"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
