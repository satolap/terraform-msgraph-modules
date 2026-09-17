variable "team_template_id" {
  description = "The unique identifier of teamTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_template_id)) > 0
    error_message = "team_template_id must not be empty."
  }
}

variable "team_template_definition_id" {
  description = "The unique identifier of teamTemplateDefinition"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_template_definition_id)) > 0
    error_message = "team_template_definition_id must not be empty."
  }
}

variable "created_by" {
  description = "Identity of the user who created the entity."
  type        = any
  default     = null
}

variable "draft_shift" {
  description = "Draft changes in the shift. Draft changes are only visible to managers. The changes are visible to employees when they're shared, which copies the changes from the draftShift to the sharedShift property."
  type        = any
  default     = null
}

variable "is_staged_for_deletion" {
  description = "The shift is marked for deletion, a process that is finalized when the schedule is shared."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.shift"
  nullable    = false
}

variable "scheduling_group_id" {
  description = "ID of the scheduling group the shift is part of. Required."
  type        = string
  default     = null
}

variable "shared_shift" {
  description = "The shared version of this shift that is viewable by both employees and managers. Updates to the sharedShift property send notifications to users in the Teams client."
  type        = any
  default     = null
}

variable "user_id" {
  description = "ID of the user assigned to the shift. Required."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime", "schedulingGroupInfo", "teamInfo", "userInfo"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
