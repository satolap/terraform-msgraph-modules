variable "app_health_metrics" {
  description = "The scores and insights for the application health metrics."
  type        = any
  default     = null
}

variable "battery_health_metrics" {
  description = "The scores and insights for the battery health metrics."
  type        = any
  default     = null
}

variable "best_practices_metrics" {
  description = "The scores and insights for the best practices metrics."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date the custom baseline was created. The value cannot be modified and is automatically populated when the baseline is created. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 would look like this: '2014-01-01T00:00:00Z'. Returned by default."
  type        = string
  default     = null
}

variable "device_boot_performance_metrics" {
  description = "The scores and insights for the device boot performance metrics."
  type        = any
  default     = null
}

variable "display_name" {
  description = "The name of the baseline."
  type        = string
  default     = null
}

variable "is_built_in" {
  description = "When TRUE, indicates the current baseline is the commercial median baseline. When FALSE, indicates it is a custom baseline. FALSE by default."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsBaseline"
  nullable    = false
}

variable "reboot_analytics_metrics" {
  description = "The scores and insights for the reboot analytics metrics."
  type        = any
  default     = null
}

variable "resource_performance_metrics" {
  description = "The scores and insights for the resource performance metrics."
  type        = any
  default     = null
}

variable "work_from_anywhere_metrics" {
  description = "The scores and insights for the work from anywhere metrics."
  type        = any
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
