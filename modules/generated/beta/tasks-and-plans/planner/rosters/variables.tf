variable "assigned_sensitivity_label" {
  description = "The sensitivity label applied to the roster. If mandatory labeling is enabled for the user and no label is specified, the user can't create the roster. Also, if labels are mandatory for the user, the user can't change the label of the roster to null. The possible values are: standard, privileged, auto, unknownFutureValue."
  type        = any
  default     = null
}

variable "members" {
  description = "Retrieves the members of the plannerRoster."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.plannerRosterMember")
    roles      = optional(list(string))
    tenantId   = optional(string)
    userId     = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.plannerRoster"
  nullable    = false
}

variable "plans" {
  description = "Retrieves the plans contained by the plannerRoster."
  type = list(object({
    odata_type                        = optional(string, "#microsoft.graph.plannerPlan")
    container                         = optional(any)
    contentSensitivityLabelAssignment = optional(any)
    creationSource                    = optional(any)
    owner                             = optional(string)
    sharedWithContainers = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.plannerSharedWithContainer")
      accessLevel = optional(string)
      containerId = optional(string)
      type        = optional(any)
      url         = optional(string)
    })))
    title = optional(string)
  }))
  default = null
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
