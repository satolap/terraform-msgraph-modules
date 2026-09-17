# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "anomalyId"                               = var.anomaly_id
    "anomalyOnDeviceFirstOccurrenceDateTime"  = var.anomaly_on_device_first_occurrence_date_time
    "anomalyOnDeviceLatestOccurrenceDateTime" = var.anomaly_on_device_latest_occurrence_date_time
    "correlationGroupId"                      = var.correlation_group_id
    "deviceId"                                = var.device_id
    "deviceManufacturer"                      = var.device_manufacturer
    "deviceModel"                             = var.device_model
    "deviceName"                              = var.device_name
    "deviceStatus"                            = var.device_status
    "@odata.type"                             = var.odata_type
    "osName"                                  = var.os_name
    "osVersion"                               = var.os_version
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/userExperienceAnalyticsAnomalyDevice"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
