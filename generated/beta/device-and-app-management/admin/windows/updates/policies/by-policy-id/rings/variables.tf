variable "policy_id" {
  description = "The unique identifier of policy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.policy_id)) > 0
    error_message = "policy_id must not be empty."
  }
}

variable "deferral_in_days" {
  description = "The quality update deferral period in days. The value must be between 0 and 30. Optional."
  type        = number
  default     = null
}

variable "description" {
  description = "The ring description. The maximum length is 1,500 characters. Required"
  type        = string
  default     = null
}

variable "display_name" {
  description = "The ring display name. The maximum length is 200 characters. Required."
  type        = string
  default     = null
}

variable "excluded_group_assignment" {
  description = "Microsoft Graph excludedGroupAssignment property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.windowsUpdates.excludedGroupAssignment")
    assignments = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.windowsUpdates.assignedGroup")
      group      = optional(any)
    })))
  })
  default = null
}

variable "included_group_assignment" {
  description = "Microsoft Graph includedGroupAssignment property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.windowsUpdates.includedGroupAssignment")
    assignments = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.windowsUpdates.assignedGroup")
      group      = optional(any)
    })))
  })
  default = null
}

variable "is_paused" {
  description = "The pause action for the quality update ring policy. Required."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsUpdates.ring"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
