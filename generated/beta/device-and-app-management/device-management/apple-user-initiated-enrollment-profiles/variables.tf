variable "assignments" {
  description = "The list of assignments for this profile."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.appleEnrollmentProfileAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "available_enrollment_type_options" {
  description = "List of available enrollment type options"
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.appleOwnerTypeEnrollmentType")
    enrollmentType = optional(string)
    ownerType      = optional(string)
  }))
  default = null
}

variable "created_date_time" {
  description = "Profile creation time"
  type        = string
  default     = null
}

variable "default_enrollment_type" {
  description = "Microsoft Graph defaultEnrollmentType property."
  type        = string
  default     = null

  validation {
    condition     = var.default_enrollment_type == null ? true : contains(["unknown", "device", "user", "accountDrivenUserEnrollment", "webDeviceEnrollment", "unknownFutureValue"], var.default_enrollment_type)
    error_message = "default_enrollment_type must be one of the documented enum values."
  }
}

variable "description" {
  description = "Description of the profile"
  type        = string
  default     = null
}

variable "display_name" {
  description = "Name of the profile"
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Profile last modified time"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.appleUserInitiatedEnrollmentProfile"
  nullable    = false
}

variable "platform" {
  description = "Supported platform types."
  type        = string
  default     = null

  validation {
    condition     = var.platform == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "androidWorkProfile", "unknown", "androidAOSP", "androidMobileApplicationManagement", "iOSMobileApplicationManagement", "unknownFutureValue", "windowsMobileApplicationManagement"], var.platform)
    error_message = "platform must be one of the documented enum values."
  }
}

variable "priority" {
  description = "Priority, 0 is highest"
  type        = number
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
