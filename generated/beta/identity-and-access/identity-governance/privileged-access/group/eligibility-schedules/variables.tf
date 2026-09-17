variable "access_id" {
  description = "The identifier of the membership or ownership eligibility to the group that is governed by PIM. Required. The possible values are: owner, member. Supports $filter (eq)."
  type        = any
  default     = null

  validation {
    condition     = var.access_id == null ? true : contains(["owner", "member", "unknownFutureValue"], var.access_id)
    error_message = "access_id must be one of the documented enum values."
  }
}

variable "created_date_time" {
  description = "When the schedule was created. Optional."
  type        = string
  default     = null
}

variable "created_using" {
  description = "The identifier of the access assignment or eligibility request that created this schedule. Optional."
  type        = string
  default     = null
}

variable "group" {
  description = "References the group that is the scope of the membership or ownership eligibility through PIM for Groups. Supports $expand."
  type        = any
  default     = null
}

variable "group_id" {
  description = "The identifier of the group representing the scope of the membership or ownership eligibility through PIM for Groups. Required. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "member_type" {
  description = "Indicates whether the assignment is derived from a group assignment. It can further imply whether the caller can manage the schedule. Required. The possible values are: direct, group, unknownFutureValue. Supports $filter (eq)."
  type        = any
  default     = null

  validation {
    condition     = var.member_type == null ? true : contains(["direct", "group", "unknownFutureValue"], var.member_type)
    error_message = "member_type must be one of the documented enum values."
  }
}

variable "modified_date_time" {
  description = "When the schedule was last modified. Optional."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.privilegedAccessGroupEligibilitySchedule"
  nullable    = false
}

variable "principal" {
  description = "References the principal that's in the scope of this membership or ownership eligibility request to the group that's governed by PIM. Supports $expand."
  type        = any
  default     = null
}

variable "principal_id" {
  description = "The identifier of the principal whose membership or ownership eligibility is granted through PIM for Groups. Required. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "schedule_info" {
  description = "Represents the period of the access assignment or eligibility. The scheduleInfo can represent a single occurrence or multiple recurring instances. Required."
  type        = any
  default     = null
}

variable "status" {
  description = "The status of the access assignment or eligibility request. The possible values are: Canceled, Denied, Failed, Granted, PendingAdminDecision, PendingApproval, PendingProvisioning, PendingScheduleCreation, Provisioned, Revoked, and ScheduleCreated. Not nullable. Optional."
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
