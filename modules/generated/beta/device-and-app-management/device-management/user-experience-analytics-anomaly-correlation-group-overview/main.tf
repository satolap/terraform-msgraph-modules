# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "anomalyCorrelationGroupCount"         = var.anomaly_correlation_group_count
    "anomalyId"                            = var.anomaly_id
    "correlationGroupAnomalousDeviceCount" = var.correlation_group_anomalous_device_count
    "correlationGroupAtRiskDeviceCount"    = var.correlation_group_at_risk_device_count
    "correlationGroupDeviceCount"          = var.correlation_group_device_count
    "correlationGroupFeatures"             = (var.correlation_group_features == null ? null : [for item0 in var.correlation_group_features : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deviceFeatureType" = item0["deviceFeatureType"], "values" = (item0["values"] == null ? null : [for item2 in item0["values"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "correlationGroupId"                   = var.correlation_group_id
    "correlationGroupPrevalence"           = var.correlation_group_prevalence
    "correlationGroupPrevalencePercentage" = var.correlation_group_prevalence_percentage
    "@odata.type"                          = var.odata_type
    "totalDeviceCount"                     = var.total_device_count
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/userExperienceAnalyticsAnomalyCorrelationGroupOverview"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
