variable "mobile_app_troubleshooting_event_id" {
  description = "The unique identifier of mobileAppTroubleshootingEvent"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.mobile_app_troubleshooting_event_id)) > 0
    error_message = "mobile_app_troubleshooting_event_id must not be empty."
  }
}

variable "completed_date_time" {
  description = "Time at which the upload log request reached a completed state if not completed yet NULL will be returned."
  type        = string
  default     = null
}

variable "custom_log_folders" {
  description = "List of log folders."
  type        = list(string)
  default     = null
}

variable "error_message" {
  description = "Indicates error message if any during the upload process."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.appLogCollectionRequest"
  nullable    = false
}

variable "status" {
  description = "AppLogUploadStatus"
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["pending", "completed", "failed", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
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
