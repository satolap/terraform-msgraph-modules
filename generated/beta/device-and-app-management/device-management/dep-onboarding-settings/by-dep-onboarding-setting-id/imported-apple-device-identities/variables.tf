variable "dep_onboarding_setting_id" {
  description = "The unique identifier of depOnboardingSetting"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.dep_onboarding_setting_id)) > 0
    error_message = "dep_onboarding_setting_id must not be empty."
  }
}

variable "created_date_time" {
  description = "Created Date Time of the device"
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the device"
  type        = string
  default     = null
}

variable "discovery_source" {
  description = "Microsoft Graph discoverySource property."
  type        = string
  default     = null

  validation {
    condition     = var.discovery_source == null ? true : contains(["unknown", "adminImport", "deviceEnrollmentProgram"], var.discovery_source)
    error_message = "discovery_source must be one of the documented enum values."
  }
}

variable "enrollment_state" {
  description = "Microsoft Graph enrollmentState property."
  type        = string
  default     = null

  validation {
    condition     = var.enrollment_state == null ? true : contains(["unknown", "enrolled", "pendingReset", "failed", "notContacted", "blocked"], var.enrollment_state)
    error_message = "enrollment_state must be one of the documented enum values."
  }
}

variable "is_deleted" {
  description = "Indicates if the device is deleted from Apple Business Manager"
  type        = bool
  default     = null
}

variable "is_supervised" {
  description = "Indicates if the Apple device is supervised."
  type        = bool
  default     = null
}

variable "last_contacted_date_time" {
  description = "Last Contacted Date Time of the device"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.importedAppleDeviceIdentity"
  nullable    = false
}

variable "platform" {
  description = "Supported platform types for policies."
  type        = string
  default     = null

  validation {
    condition     = var.platform == null ? true : contains(["unknown", "ios", "android", "windows", "windowsMobile", "macOS", "visionOS", "tvOS", "unknownFutureValue"], var.platform)
    error_message = "platform must be one of the documented enum values."
  }
}

variable "requested_enrollment_profile_assignment_date_time" {
  description = "The time enrollment profile was assigned to the device"
  type        = string
  default     = null
}

variable "requested_enrollment_profile_id" {
  description = "Enrollment profile Id admin intends to apply to the device during next enrollment"
  type        = string
  default     = null
}

variable "serial_number" {
  description = "Device serial number"
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
