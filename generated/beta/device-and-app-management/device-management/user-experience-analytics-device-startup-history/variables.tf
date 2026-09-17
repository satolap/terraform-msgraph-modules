variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsDeviceStartupHistory"
  nullable    = false
}

variable "restart_category" {
  description = "Operating System restart category."
  type        = string
  default     = null

  validation {
    condition     = var.restart_category == null ? true : contains(["unknown", "restartWithUpdate", "restartWithoutUpdate", "blueScreen", "shutdownWithUpdate", "shutdownWithoutUpdate", "longPowerButtonPress", "bootError", "update", "unknownFutureValue"], var.restart_category)
    error_message = "restart_category must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["coreBootTimeInMs", "coreLoginTimeInMs", "deviceId", "featureUpdateBootTimeInMs", "groupPolicyBootTimeInMs", "groupPolicyLoginTimeInMs", "id", "isFeatureUpdate", "isFirstLogin", "operatingSystemVersion", "responsiveDesktopTimeInMs", "restartFaultBucket", "restartStopCode", "startTime", "totalBootTimeInMs", "totalLoginTimeInMs"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
