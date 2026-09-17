variable "active_devices" {
  description = "Number of active devices for that os version. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "average_battery_age_in_days" {
  description = "The mean of the battery age for all devices running a particular operating system version in a tenant. Unit in days. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "average_estimated_runtime_in_minutes" {
  description = "The mean of the estimated runtimes on full charge for all devices running a particular operating system version. Unit in minutes. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "average_max_capacity_percentage" {
  description = "The mean of the maximum capacity for all devices running a particular operating system version. Maximum capacity measures the full charge vs. design capacity for a device’s batteries.. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "mean_full_battery_drain_count" {
  description = "The mean of number of times the battery has been discharged an amount that equals 100% of its capacity for all devices running a particular operating system version in a tenant. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "median_estimated_runtime_in_minutes" {
  description = "The median of the estimated runtimes on full charge for all devices running a particular operating system version. Unit in minutes. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "median_full_battery_drain_count" {
  description = "The median of number of times the battery has been discharged an amount that equals 100% of its capacity for all devices running a particular operating system version in a tenant. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "median_max_capacity_percentage" {
  description = "The median of the maximum capacity for all devices running a particular operating system version. Maximum capacity measures the full charge vs. design capacity for a device’s batteries.. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsBatteryHealthOsPerformance"
  nullable    = false
}

variable "os_battery_health_score" {
  description = "A weighted average of battery health score across all devices running a particular operating system version. Values range from 0-100. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "os_build_number" {
  description = "Build number of the operating system."
  type        = string
  default     = null
}

variable "os_health_status" {
  description = "Microsoft Graph osHealthStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.os_health_status == null ? true : contains(["unknown", "insufficientData", "needsAttention", "meetingGoals", "unknownFutureValue"], var.os_health_status)
    error_message = "os_health_status must be one of the documented enum values."
  }
}

variable "os_version" {
  description = "Version of the operating system."
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
