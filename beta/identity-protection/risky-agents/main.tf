# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "additionalInfo"           = var.additional_info
    "agentDisplayName"         = var.agent_display_name
    "agentPlatform"            = var.agent_platform
    "associatedUserId"         = var.associated_user_id
    "blastRadiusRisk"          = (var.blast_radius_risk == null ? null : { for key0, value0 in { "@odata.type" = var.blast_radius_risk["odata_type"], "riskIndicators" = (var.blast_radius_risk["riskIndicators"] == null ? null : [for item1 in var.blast_radius_risk["riskIndicators"] : item1 if item1 != null]), "riskLevel" = var.blast_radius_risk["riskLevel"], "riskRecommendations" = (var.blast_radius_risk["riskRecommendations"] == null ? null : [for item1 in var.blast_radius_risk["riskRecommendations"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "displayName" = item1["displayName"], "severity" = item1["severity"] } : key2 => value2 if value2 != null }) if item1 != null]), "riskUrl" = var.blast_radius_risk["riskUrl"] } : key0 => value0 if value0 != null })
    "blueprintId"              = var.blueprint_id
    "deviceId"                 = var.device_id
    "exposureRisk"             = (var.exposure_risk == null ? null : { for key0, value0 in { "@odata.type" = var.exposure_risk["odata_type"], "riskIndicators" = (var.exposure_risk["riskIndicators"] == null ? null : [for item1 in var.exposure_risk["riskIndicators"] : item1 if item1 != null]), "riskLevel" = var.exposure_risk["riskLevel"], "riskRecommendations" = (var.exposure_risk["riskRecommendations"] == null ? null : [for item1 in var.exposure_risk["riskRecommendations"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "displayName" = item1["displayName"], "severity" = item1["severity"] } : key2 => value2 if value2 != null }) if item1 != null]), "riskUrl" = var.exposure_risk["riskUrl"] } : key0 => value0 if value0 != null })
    "identityType"             = var.identity_type
    "isDeleted"                = var.is_deleted
    "isEnabled"                = var.is_enabled
    "isProcessing"             = var.is_processing
    "machineId"                = var.machine_id
    "@odata.type"              = var.odata_type
    "riskDetail"               = var.risk_detail
    "riskLastModifiedDateTime" = var.risk_last_modified_date_time
    "riskLevel"                = var.risk_level
    "riskState"                = var.risk_state
    "runtimeRisk"              = (var.runtime_risk == null ? null : { for key0, value0 in { "@odata.type" = var.runtime_risk["odata_type"], "alerts" = (var.runtime_risk["alerts"] == null ? null : [for item1 in var.runtime_risk["alerts"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "displayName" = item1["displayName"], "mitreTechniques" = (item1["mitreTechniques"] == null ? null : [for item3 in item1["mitreTechniques"] : item3 if item3 != null]), "providerAlertId" = item1["providerAlertId"], "severity" = item1["severity"] } : key2 => value2 if value2 != null }) if item1 != null]), "riskLevel" = var.runtime_risk["riskLevel"], "riskUrl" = var.runtime_risk["riskUrl"] } : key0 => value0 if value0 != null })
    "sources"                  = (var.sources == null ? null : [for item0 in var.sources : item0 if item0 != null])
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
