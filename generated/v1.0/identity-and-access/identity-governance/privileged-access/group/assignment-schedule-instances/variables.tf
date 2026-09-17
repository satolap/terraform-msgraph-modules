variable "access_id" {
  description = "The identifier of the membership or ownership assignment relationship to the group. Required. The possible values are: owner, member,  unknownFutureValue. Supports $filter (eq)."
  type        = any
  default     = null

  validation {
    condition     = var.access_id == null ? true : contains(["owner", "member", "unknownFutureValue"], var.access_id)
    error_message = "access_id must be one of the documented enum values."
  }
}

variable "activated_using" {
  description = "When the request activates a membership or ownership in PIM for Groups, this object represents the eligibility request for the group. Otherwise, it is null."
  type        = any
  default     = null
}

variable "assignment_schedule_id" {
  description = "The identifier of the privilegedAccessGroupAssignmentSchedule from which this instance was created. Required. Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "assignment_type" {
  description = "Indicates whether the membership or ownership assignment is granted through activation of an eligibility or through direct assignment. Required. The possible values are: assigned, activated, unknownFutureValue. Supports $filter (eq)."
  type        = any
  default     = null

  validation {
    condition     = var.assignment_type == null ? true : contains(["assigned", "activated", "unknownFutureValue"], var.assignment_type)
    error_message = "assignment_type must be one of the documented enum values."
  }
}

variable "end_date_time" {
  description = "When the schedule instance ends. Required."
  type        = string
  default     = null
}

variable "group" {
  description = "References the group that is the scope of the membership or ownership assignment through PIM for Groups. Supports $expand."
  type        = any
  default     = null
}

variable "group_id" {
  description = "The identifier of the group representing the scope of the membership or ownership assignment through PIM for Groups. Optional. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "member_type" {
  description = "Indicates whether the assignment is derived from a group assignment. It can further imply whether the caller can manage the assignment schedule. Required. The possible values are: direct, group, unknownFutureValue. Supports $filter (eq)."
  type        = any
  default     = null

  validation {
    condition     = var.member_type == null ? true : contains(["direct", "group", "unknownFutureValue"], var.member_type)
    error_message = "member_type must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.privilegedAccessGroupAssignmentScheduleInstance"
  nullable    = false
}

variable "principal" {
  description = "References the principal that's in the scope of the membership or ownership assignment request through the group that's governed by PIM. Supports $expand."
  type        = any
  default     = null
}

variable "principal_id" {
  description = "The identifier of the principal whose membership or ownership assignment to the group is managed through PIM for Groups. Required. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "start_date_time" {
  description = "When this instance starts. Required."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
