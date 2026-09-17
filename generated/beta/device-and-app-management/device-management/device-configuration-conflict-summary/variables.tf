variable "conflicting_device_configurations" {
  description = "The set of policies in conflict with the given setting"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.settingSource")
    displayName = optional(string)
    id          = optional(string)
    sourceType  = optional(string)
  }))
  default = null
}

variable "contributing_settings" {
  description = "The set of settings in conflict with the given policies"
  type        = list(string)
  default     = null
}

variable "device_checkins_impacted" {
  description = "The count of checkins impacted by the conflicting policies and settings"
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceConfigurationConflictSummary"
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
