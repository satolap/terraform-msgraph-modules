variable "expiration_date_time" {
  description = "The date and time when the export job expires."
  type        = string
  default     = null
}

variable "export_url" {
  description = "The storage account URL of the exported report. It can be used to download the file."
  type        = string
  default     = null
}

variable "filter" {
  description = "The filter applied on the report."
  type        = string
  default     = null
}

variable "format" {
  description = "The format of the exported report."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcExportJob"
  nullable    = false
}

variable "report_name" {
  description = "The report name."
  type        = any
  default     = null

  validation {
    condition     = var.report_name == null ? true : contains(["remoteConnectionHistoricalReports", "dailyAggregatedRemoteConnectionReports", "totalAggregatedRemoteConnectionReports", "unknownFutureValue", "noLicenseAvailableConnectivityFailureReport", "frontlineLicenseUsageReport", "frontlineLicenseUsageRealTimeReport", "remoteConnectionQualityReports", "inaccessibleCloudPcReports", "actionStatusReport", "rawRemoteConnectionReports", "cloudPcUsageCategoryReports", "crossRegionDisasterRecoveryReport", "performanceTrendReport", "inaccessibleCloudPcTrendReport", "regionalConnectionQualityTrendReport", "regionalConnectionQualityInsightsReport", "remoteConnectionQualityReport", "frontlineLicenseHourlyUsageReport", "frontlineRealtimeUserConnectionsReport", "bulkActionStatusReport", "troubleshootDetailsReport", "troubleshootTrendCountReport", "troubleshootRegionalReport", "troubleshootIssueCountReport", "cloudPcInsightReport", "regionalInaccessibleCloudPcTrendReport", "cloudPcUsageCategoryReport", "cloudPCInventoryReport"], var.report_name)
    error_message = "report_name must be one of the documented enum values."
  }
}

variable "request_date_time" {
  description = "The date and time when the export job was requested."
  type        = string
  default     = null
}

variable "select" {
  description = "The selected columns of the report."
  type        = list(string)
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["exportJobStatus", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
