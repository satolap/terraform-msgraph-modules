variable "battery_age_in_days" {
  description = "Estimated battery age. Unit in days. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "device_batteries_details" {
  description = "Properties (maxCapacity and cycleCount) related to all batteries of the device."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.userExperienceAnalyticsDeviceBatteryDetail")
    batteryId             = optional(string)
    fullBatteryDrainCount = optional(number)
    maxCapacityPercentage = optional(number)
  }))
  default = null
}

variable "device_battery_count" {
  description = "Number of batteries in a user device. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "device_battery_health_score" {
  description = "A weighted average of a device’s maximum capacity score and runtime estimate score. Values range from 0-100. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "device_battery_tags" {
  description = "Tags for computed information on how battery on the device is behaving. E.g. newbattery, batterycapacityred, designcapacityzero, etc."
  type        = list(string)
  default     = null
}

variable "device_id" {
  description = "The unique identifier of the device, Intune DeviceID."
  type        = string
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

variable "device_name" {
  description = "Device friendly name."
  type        = string
  default     = null
}

variable "estimated_runtime_in_minutes" {
  description = "The estimated runtime of the device when the battery is fully charged. Unit in minutes. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "full_battery_drain_count" {
  description = "Number of times the battery has been discharged an amount that equals 100% of its capacity, but not necessarily by discharging it from 100% to 0%. Valid values 0 to 2147483647"
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

variable "manufacturer" {
  description = "The manufacturer name of the device. Deprecated in favor of DeviceManufacturerName."
  type        = string
  default     = null
}

variable "max_capacity_percentage" {
  description = "Ratio of current capacity and design capacity of the battery with the lowest capacity. Unit in percentage and values range from 0-100. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "model" {
  description = "The model name of the device. Deprecated in favor of DeviceModelName."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsBatteryHealthDevicePerformance"
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
