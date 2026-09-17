variable "device_id" {
  description = "The unique identifier of the device, Intune DeviceID or SCCM device id."
  type        = string
  default     = null
}

variable "estimated_runtime_in_minutes" {
  description = "The estimated runtime of the device when the battery is fully charged. Unit in minutes. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsBatteryHealthDeviceRuntimeHistory"
  nullable    = false
}

variable "runtime_date_time" {
  description = "The datetime for the instance of runtime history."
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
