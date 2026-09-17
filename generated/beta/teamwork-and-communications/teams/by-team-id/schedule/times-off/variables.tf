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
  description = "Identity of the user who created the entity."
  type        = any
  default     = null
}

variable "draft_time_off" {
  description = "The draft version of this timeOff item that is viewable by managers. It must be shared before it is visible to team members. Required."
  type        = any
  default     = null
}

variable "is_staged_for_deletion" {
  description = "The timeOff is marked for deletion, a process that is finalized when the schedule is shared."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.timeOff"
  nullable    = false
}

variable "shared_time_off" {
  description = "The shared version of this timeOff that is viewable by both employees and managers. Updates to the sharedTimeOff property send notifications to users in the Teams client. Required."
  type        = any
  default     = null
}

variable "user_id" {
  description = "ID of the user assigned to the timeOff. Required."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime", "teamInfo", "userInfo"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
