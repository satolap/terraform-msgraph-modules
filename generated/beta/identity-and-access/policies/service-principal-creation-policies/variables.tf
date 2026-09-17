variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "description" {
  description = "Description for this policy. Required."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name for this policy. Required."
  type        = string
  default     = null
}

variable "excludes" {
  description = "Microsoft Graph excludes property."
  type = list(object({
    odata_type                            = optional(string, "#microsoft.graph.servicePrincipalCreationConditionSet")
    applicationIds                        = optional(list(string))
    applicationPublisherIds               = optional(list(string))
    applicationTenantIds                  = optional(list(string))
    applicationsFromVerifiedPublisherOnly = optional(bool)
    certifiedApplicationsOnly             = optional(bool)
  }))
  default = null
}

variable "includes" {
  description = "Microsoft Graph includes property."
  type = list(object({
    odata_type                            = optional(string, "#microsoft.graph.servicePrincipalCreationConditionSet")
    applicationIds                        = optional(list(string))
    applicationPublisherIds               = optional(list(string))
    applicationTenantIds                  = optional(list(string))
    applicationsFromVerifiedPublisherOnly = optional(bool)
    certifiedApplicationsOnly             = optional(bool)
  }))
  default = null
}

variable "is_built_in" {
  description = "Microsoft Graph isBuiltIn property."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.servicePrincipalCreationPolicy"
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
