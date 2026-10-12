variable "expiration_date_time" {
  description = "Time that the exported report expires."
  type        = string
  default     = null
}

variable "filter" {
  description = "Filters applied on the report. The maximum length allowed for this property is 2000 characters."
  type        = string
  default     = null
}

variable "format" {
  description = "Possible values for the file format of a report to be exported."
  type        = string
  default     = null

  validation {
    condition     = var.format == null ? true : contains(["csv", "pdf", "json", "unknownFutureValue"], var.format)
    error_message = "format must be one of the documented enum values."
  }
}

variable "localization_type" {
  description = "Configures how the requested export job is localized."
  type        = string
  default     = null

  validation {
    condition     = var.localization_type == null ? true : contains(["localizedValuesAsAdditionalColumn", "replaceLocalizableValues"], var.localization_type)
    error_message = "localization_type must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementExportJob"
  nullable    = false
}

variable "report_name" {
  description = "Name of the report. The maximum length allowed for this property is 2000 characters."
  type        = string
  default     = null
}

variable "request_date_time" {
  description = "Time that the exported report was requested."
  type        = string
  default     = null
}

variable "select" {
  description = "Columns selected from the report. The maximum number of allowed columns names is 256. The maximum length allowed for each column name in this property is 1000 characters."
  type        = list(string)
  default     = null
}

variable "snapshot_id" {
  description = "A snapshot is an identifiable subset of the dataset represented by the ReportName. A sessionId or CachedReportConfiguration id can be used here. If a sessionId is specified, Filter, Select, and OrderBy are applied to the data represented by the sessionId. Filter, Select, and OrderBy cannot be specified together with a CachedReportConfiguration id. The maximum length allowed for this property is 128 characters."
  type        = string
  default     = null
}

variable "status" {
  description = "Possible statuses associated with a generated report."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "notStarted", "inProgress", "completed", "failed"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "url" {
  description = "Temporary location of the exported report."
  type        = string
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
