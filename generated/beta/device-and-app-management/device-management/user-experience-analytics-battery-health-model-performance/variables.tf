variable "active_devices" {
  description = "Number of active devices for that model. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "average_battery_age_in_days" {
  description = "The mean of the battery age for all devices of a given model in a tenant. Unit in days. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "average_estimated_runtime_in_minutes" {
  description = "The mean of the estimated runtimes on full charge for all devices of a given model. Unit in minutes. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "average_max_capacity_percentage" {
  description = "The mean of the maximum capacity for all devices of a given model. Maximum capacity measures the full charge vs. design capacity for a device’s batteries.. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "device_manufacturer_name" {
  description = "The manufacturer name of the device."
  type        = string
  default     = null
}

variable "device_model_name" {
  description = "The model name of the device."
  type        = string
  default     = null
}

variable "manufacturer" {
  description = "Name of the device manufacturer. Deprecated in favor of DeviceManufacturerName."
  type        = string
  default     = null
}

variable "mean_full_battery_drain_count" {
  description = "The mean of number of times the battery has been discharged an amount that equals 100% of its capacity for all devices of a given model in a tenant. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "median_estimated_runtime_in_minutes" {
  description = "The median of the estimated runtimes on full charge for all devices of a given model. Unit in minutes. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "median_full_battery_drain_count" {
  description = "The median of number of times the battery has been discharged an amount that equals 100% of its capacity for all devices of a given model in a tenant. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "median_max_capacity_percentage" {
  description = "The median of the maximum capacity for all devices of a given model. Maximum capacity measures the full charge vs. design capacity for a device’s batteries.. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "model" {
  description = "The model name of the device. Deprecated in favor of DeviceModelName."
  type        = string
  default     = null
}

variable "model_battery_health_score" {
  description = "A weighted average of a model’s maximum capacity score and runtime estimate score. Values range from 0-100. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "model_health_status" {
  description = "Microsoft Graph modelHealthStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.model_health_status == null ? true : contains(["unknown", "insufficientData", "needsAttention", "meetingGoals", "unknownFutureValue"], var.model_health_status)
    error_message = "model_health_status must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsBatteryHealthModelPerformance"
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
