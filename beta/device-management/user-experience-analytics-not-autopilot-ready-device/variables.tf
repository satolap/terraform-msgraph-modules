variable "auto_pilot_profile_assigned" {
  description = "The intune device's autopilotProfileAssigned."
  type        = bool
  default     = null
}

variable "auto_pilot_registered" {
  description = "The intune device's autopilotRegistered."
  type        = bool
  default     = null
}

variable "azure_ad_join_type" {
  description = "The intune device's azure Ad joinType."
  type        = string
  default     = null
}

variable "azure_ad_registered" {
  description = "The intune device's azureAdRegistered."
  type        = bool
  default     = null
}

variable "device_name" {
  description = "The intune device's name."
  type        = string
  default     = null
}

variable "managed_by" {
  description = "The intune device's managed by."
  type        = string
  default     = null
}

variable "manufacturer" {
  description = "The intune device's manufacturer."
  type        = string
  default     = null
}

variable "model" {
  description = "The intune device's model."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsNotAutopilotReadyDevice"
  nullable    = false
}

variable "serial_number" {
  description = "The intune device's serial number."
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
