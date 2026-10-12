variable "device_id" {
  description = "The id of the device where the event occurred."
  type        = string
  default     = null
}

variable "event_date_time" {
  description = "The time the event occured."
  type        = string
  default     = null
}

variable "event_details" {
  description = "The details provided by the event, format depends on event type."
  type        = string
  default     = null
}

variable "event_level" {
  description = "Indicates device event level. Possible values are: None, Verbose, Information, Warning, Error, Critical"
  type        = string
  default     = null

  validation {
    condition     = var.event_level == null ? true : contains(["none", "verbose", "information", "warning", "error", "critical", "unknownFutureValue"], var.event_level)
    error_message = "event_level must be one of the documented enum values."
  }
}

variable "event_name" {
  description = "The name of the event. Examples include: BootEvent, LogonEvent, AppCrashEvent, AppHangEvent."
  type        = string
  default     = null
}

variable "event_source" {
  description = "The source of the event. Examples include: Intune, Sccm."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsDeviceTimelineEvent"
  nullable    = false
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
