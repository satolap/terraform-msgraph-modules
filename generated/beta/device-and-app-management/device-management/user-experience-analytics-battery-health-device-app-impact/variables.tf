variable "app_display_name" {
  description = "User friendly display name for the app. Eg: Outlook"
  type        = string
  default     = null
}

variable "app_name" {
  description = "App name. Eg: oltk.exe"
  type        = string
  default     = null
}

variable "app_publisher" {
  description = "App publisher. Eg: Microsoft Corporation"
  type        = string
  default     = null
}

variable "battery_usage_percentage" {
  description = "The percent of total battery power used by this application when the device was not plugged into AC power, over 14 days. Unit in percentage. Valid values 0 to 1.79769313486232E+308"
  type        = any
  default     = null
}

variable "device_id" {
  description = "The unique identifier of the device, Intune DeviceID or SCCM device id."
  type        = string
  default     = null
}

variable "is_foreground_app" {
  description = "true if the user had active interaction with the app."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsBatteryHealthDeviceAppImpact"
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
