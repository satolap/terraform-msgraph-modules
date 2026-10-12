variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.externalUsersSelfServiceSignUpEventsFlow"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "conditions" {
  description = "The conditions representing the context of the authentication request that's used to decide whether the events policy is invoked.  Supports $filter (eq). See support for filtering on user flows for syntax information."
  type = object({
    odata_type = optional(string, "#microsoft.graph.authenticationConditions")
    applications = optional(object({
      odata_type             = optional(string, "#microsoft.graph.authenticationConditionsApplications")
      includeAllApplications = optional(bool)
      includeApplications = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.authenticationConditionApplication")
        appId      = optional(string)
      })))
    }))
  })
  default = null
}

variable "description" {
  description = "The description of the events policy."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Required. The display name for the events policy."
  type        = string
  default     = null
}

variable "priority" {
  description = "The priority to use for each individual event of the events policy. If multiple competing listeners for an event have the same priority, one is chosen and an error is silently logged. Defaults to 500."
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
