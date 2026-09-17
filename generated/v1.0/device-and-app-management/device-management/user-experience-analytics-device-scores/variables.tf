variable "health_status" {
  description = "Microsoft Graph healthStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.health_status == null ? true : contains(["unknown", "insufficientData", "needsAttention", "meetingGoals", "unknownFutureValue"], var.health_status)
    error_message = "health_status must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsDeviceScores"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["appReliabilityScore", "batteryHealthScore", "deviceName", "endpointAnalyticsScore", "id", "manufacturer", "model", "startupPerformanceScore", "workFromAnywhereScore"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
