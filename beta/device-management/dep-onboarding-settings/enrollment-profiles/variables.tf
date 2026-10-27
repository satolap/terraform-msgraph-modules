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

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
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
