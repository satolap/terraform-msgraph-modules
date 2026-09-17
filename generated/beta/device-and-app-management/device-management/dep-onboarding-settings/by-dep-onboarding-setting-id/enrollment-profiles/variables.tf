variable "dep_onboarding_setting_id" {
  description = "The unique identifier of depOnboardingSetting"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.dep_onboarding_setting_id)) > 0
    error_message = "dep_onboarding_setting_id must not be empty."
  }
}

variable "configuration_endpoint_url" {
  description = "Configuration endpoint url to use for Enrollment"
  type        = string
  default     = null
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

variable "enable_authentication_via_company_portal" {
  description = "Indicates to authenticate with Apple Setup Assistant instead of Company Portal."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.enrollmentProfile"
  nullable    = false
}

variable "require_company_portal_on_setup_assistant_enrolled_devices" {
  description = "Indicates that Company Portal is required on setup assistant enrolled devices"
  type        = bool
  default     = null
}

variable "requires_user_authentication" {
  description = "Indicates if the profile requires user authentication"
  type        = bool
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
