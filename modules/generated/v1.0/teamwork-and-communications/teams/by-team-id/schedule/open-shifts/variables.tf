variable "team_id" {
  description = "The unique identifier of team"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_id)) > 0
    error_message = "team_id must not be empty."
  }
}

variable "created_by" {
  description = "Identity of the creator of the entity."
  type        = any
  default     = null
}

variable "draft_open_shift" {
  description = "Draft changes in the openShift are only visible to managers until they're shared."
  type        = any
  default     = null
}

variable "is_staged_for_deletion" {
  description = "The openShift is marked for deletion, a process that is finalized when the schedule is shared."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.openShift"
  nullable    = false
}

variable "scheduling_group_id" {
  description = "The ID of the schedulingGroup that contains the openShift."
  type        = string
  default     = null
}

variable "shared_open_shift" {
  description = "The shared version of this openShift that is viewable by both employees and managers."
  type        = any
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
