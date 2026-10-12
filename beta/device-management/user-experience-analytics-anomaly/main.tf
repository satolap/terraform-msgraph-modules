# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "anomalyFirstOccurrenceDateTime"  = var.anomaly_first_occurrence_date_time
    "anomalyId"                       = var.anomaly_id
    "anomalyLatestOccurrenceDateTime" = var.anomaly_latest_occurrence_date_time
    "anomalyName"                     = var.anomaly_name
    "anomalyType"                     = var.anomaly_type
    "assetName"                       = var.asset_name
    "assetPublisher"                  = var.asset_publisher
    "assetVersion"                    = var.asset_version
    "detectionModelId"                = var.detection_model_id
    "deviceImpactedCount"             = var.device_impacted_count
    "issueId"                         = var.issue_id
    "@odata.type"                     = var.odata_type
    "severity"                        = var.severity
    "state"                           = var.state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/userExperienceAnalyticsAnomaly"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
