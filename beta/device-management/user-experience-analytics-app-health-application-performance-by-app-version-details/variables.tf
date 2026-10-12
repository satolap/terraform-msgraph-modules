variable "app_crash_count" {
  description = "The number of crashes for the app. Valid values -2147483648 to 2147483647"
  type        = number
  default     = null
}

variable "app_display_name" {
  description = "The friendly name of the application."
  type        = string
  default     = null
}

variable "app_name" {
  description = "The name of the application."
  type        = string
  default     = null
}

variable "app_publisher" {
  description = "The publisher of the application."
  type        = string
  default     = null
}

variable "app_version" {
  description = "The version of the application."
  type        = string
  default     = null
}

variable "is_latest_used_version" {
  description = "When TRUE, indicates the version of application is the latest version for that application that is in use. When FALSE, indicates the version is not the latest version. FALSE by default. Supports: $select, $OrderBy."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsAppHealthAppPerformanceByAppVersionDetails"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["deviceCountWithCrashes", "id", "isMostUsedVersion"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
