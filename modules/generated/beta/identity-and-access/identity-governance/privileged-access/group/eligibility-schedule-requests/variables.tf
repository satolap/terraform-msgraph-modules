variable "access_id" {
  description = "The identifier of membership or ownership eligibility relationship to the group. Required. The possible values are: owner, member, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.access_id == null ? true : contains(["owner", "member", "unknownFutureValue"], var.access_id)
    error_message = "access_id must be one of the documented enum values."
  }
}

variable "action" {
  description = "Represents the type of operation on the group membership or ownership assignment request. The possible values are: adminAssign, adminUpdate, adminRemove, selfActivate, selfDeactivate, adminExtend, adminRenew. adminAssign: For administrators to assign group membership or ownership to principals.adminRemove: For administrators to remove principals from group membership or ownership. adminUpdate: For administrators to change existing group membership or ownership assignments.adminExtend: For administrators to extend expiring assignments.adminRenew: For administrators to renew expired assignments.selfActivate: For principals to activate their assignments.selfDeactivate: For principals to deactivate their active assignments."
  type        = any
  default     = null

  validation {
    condition     = var.action == null ? true : contains(["adminAssign", "adminUpdate", "adminRemove", "selfActivate", "selfDeactivate", "adminExtend", "adminRenew", "selfExtend", "selfRenew", "unknownFutureValue"], var.action)
    error_message = "action must be one of the documented enum values."
  }
}

variable "approval_id" {
  description = "The identifier of the approval of the request."
  type        = string
  default     = null
}

variable "completed_date_time" {
  description = "The request completion date time."
  type        = string
  default     = null
}

variable "created_by" {
  description = "The principal that created the request."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The request creation date time."
  type        = string
  default     = null
}

variable "custom_data" {
  description = "Free text field to define any custom data for the request. Not used."
  type        = string
  default     = null
}

variable "group" {
  description = "References the group that is the scope of the membership or ownership eligibility request through PIM for Groups. Supports $expand and $select nested in $expand for select properties like id, displayName, and mail."
  type        = any
  default     = null
}

variable "group_id" {
  description = "The identifier of the group representing the scope of the membership and ownership eligibility through PIM for Groups. Required."
  type        = string
  default     = null
}

variable "is_validation_only" {
  description = "Determines whether the call is a validation or an actual call. Only set this property if you want to check whether an activation is subject to additional rules like MFA before actually submitting the request."
  type        = bool
  default     = null
}

variable "justification" {
  description = "A message provided by users and administrators when create they create the privilegedAccessGroupAssignmentScheduleRequest object."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.privilegedAccessGroupEligibilityScheduleRequest"
  nullable    = false
}

variable "principal" {
  description = "References the principal that's in the scope of the membership or ownership eligibility request through the group that's governed by PIM. Supports $expand and $select nested in $expand for id only."
  type        = any
  default     = null
}

variable "principal_id" {
  description = "The identifier of the principal whose membership or ownership eligibility to the group is managed through PIM for Groups. Required."
  type        = string
  default     = null
}

variable "schedule_info" {
  description = "The period of the group membership or ownership assignment. Recurring schedules are currently unsupported."
  type        = any
  default     = null
}

variable "status" {
  description = "The status of the request. Not nullable. The possible values are: Canceled, Denied, Failed, Granted, PendingAdminDecision, PendingApproval, PendingProvisioning, PendingScheduleCreation, Provisioned, Revoked, and ScheduleCreated. Not nullable."
  type        = string
  default     = null
}

variable "target_schedule" {
  description = "Schedule created by this request."
  type        = any
  default     = null
}

variable "target_schedule_id" {
  description = "The identifier of the schedule that's created from the eligibility request. Optional."
  type        = string
  default     = null
}

variable "ticket_info" {
  description = "Ticket details linked to the group membership or ownership assignment request including details of the ticket number and ticket system."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
