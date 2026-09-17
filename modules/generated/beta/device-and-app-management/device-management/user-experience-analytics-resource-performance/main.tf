# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "averageSpikeTimeScore"           = var.average_spike_time_score
    "cpuClockSpeedInMHz"              = var.cpu_clock_speed_in_m_hz
    "cpuDisplayName"                  = var.cpu_display_name
    "cpuSpikeTimePercentage"          = var.cpu_spike_time_percentage
    "cpuSpikeTimePercentageThreshold" = var.cpu_spike_time_percentage_threshold
    "cpuSpikeTimeScore"               = var.cpu_spike_time_score
    "deviceCount"                     = var.device_count
    "deviceId"                        = var.device_id
    "deviceName"                      = var.device_name
    "deviceResourcePerformanceScore"  = var.device_resource_performance_score
    "diskType"                        = var.disk_type
    "healthStatus"                    = var.health_status
    "machineType"                     = var.machine_type
    "manufacturer"                    = var.manufacturer
    "model"                           = var.model
    "@odata.type"                     = var.odata_type
    "ramSpikeTimePercentage"          = var.ram_spike_time_percentage
    "ramSpikeTimePercentageThreshold" = var.ram_spike_time_percentage_threshold
    "ramSpikeTimeScore"               = var.ram_spike_time_score
    "totalProcessorCoreCount"         = var.total_processor_core_count
    "totalRamInMB"                    = var.total_ram_in_mb
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/userExperienceAnalyticsResourcePerformance"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
