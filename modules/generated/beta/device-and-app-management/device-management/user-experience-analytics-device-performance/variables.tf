variable "average_blue_screens" {
  description = "Average (mean) number of Blue Screens per device in the last 30 days. Valid values 0 to 9999999"
  type        = any
  default     = null
}

variable "average_restarts" {
  description = "Average (mean) number of Restarts per device in the last 30 days. Valid values 0 to 9999999"
  type        = any
  default     = null
}

variable "blue_screen_count" {
  description = "Number of Blue Screens in the last 30 days. Valid values 0 to 9999999"
  type        = number
  default     = null
}

variable "boot_score" {
  description = "The user experience analytics device boot score."
  type        = number
  default     = null
}

variable "core_boot_time_in_ms" {
  description = "The user experience analytics device core boot time in milliseconds."
  type        = number
  default     = null
}

variable "core_login_time_in_ms" {
  description = "The user experience analytics device core login time in milliseconds."
  type        = number
  default     = null
}

variable "device_count" {
  description = "User experience analytics summarized device count."
  type        = number
  default     = null
}

variable "device_name" {
  description = "The user experience analytics device name."
  type        = string
  default     = null
}

variable "disk_type" {
  description = "Microsoft Graph diskType property."
  type        = string
  default     = null

  validation {
    condition     = var.disk_type == null ? true : contains(["unknown", "hdd", "ssd", "unknownFutureValue"], var.disk_type)
    error_message = "disk_type must be one of the documented enum values."
  }
}

variable "group_policy_boot_time_in_ms" {
  description = "The user experience analytics device group policy boot time in milliseconds."
  type        = number
  default     = null
}

variable "group_policy_login_time_in_ms" {
  description = "The user experience analytics device group policy login time in milliseconds."
  type        = number
  default     = null
}

variable "health_status" {
  description = "Microsoft Graph healthStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.health_status == null ? true : contains(["unknown", "insufficientData", "needsAttention", "meetingGoals", "unknownFutureValue"], var.health_status)
    error_message = "health_status must be one of the documented enum values."
  }
}

variable "login_score" {
  description = "The user experience analytics device login score."
  type        = number
  default     = null
}

variable "manufacturer" {
  description = "The user experience analytics device manufacturer."
  type        = string
  default     = null
}

variable "model" {
  description = "The user experience analytics device model."
  type        = string
  default     = null
}

variable "model_startup_performance_score" {
  description = "The user experience analytics model level startup performance score. Valid values -1.79769313486232E+308 to 1.79769313486232E+308"
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsDevicePerformance"
  nullable    = false
}

variable "operating_system_version" {
  description = "The user experience analytics device Operating System version."
  type        = string
  default     = null
}

variable "responsive_desktop_time_in_ms" {
  description = "The user experience analytics responsive desktop time in milliseconds."
  type        = number
  default     = null
}

variable "restart_count" {
  description = "Number of Restarts in the last 30 days. Valid values 0 to 9999999"
  type        = number
  default     = null
}

variable "startup_performance_score" {
  description = "The user experience analytics device startup performance score. Valid values -1.79769313486232E+308 to 1.79769313486232E+308"
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
