variable "action" {
  description = "Represents the type of the operation on the role assignment request. The possible values are: adminAssign, adminUpdate, adminRemove, selfActivate, selfDeactivate, adminExtend, adminRenew, selfExtend, selfRenew, unknownFutureValue. adminAssign: For administrators to assign roles to principals.adminRemove: For administrators to remove principals from roles. adminUpdate: For administrators to change existing role assignments.adminExtend: For administrators to extend expiring assignments.adminRenew: For administrators to renew expired assignments.selfActivate: For principals to activate their assignments.selfDeactivate: For principals to deactivate their active assignments.selfExtend: For principals to request to extend their expiring assignments.selfRenew: For principals to request to renew their expired assignments."
  type        = any
  default     = null

  validation {
    condition     = var.action == null ? true : contains(["adminAssign", "adminUpdate", "adminRemove", "selfActivate", "selfDeactivate", "adminExtend", "adminRenew", "selfExtend", "selfRenew", "unknownFutureValue"], var.action)
    error_message = "action must be one of the documented enum values."
  }
}

variable "activated_using" {
  description = "If the request is from an eligible administrator to activate a role, this parameter will show the related eligible assignment for that activation. Otherwise, it's null. Supports $expand and $select nested in $expand."
  type        = any
  default     = null
}

variable "app_scope_id" {
  description = "Identifier of the app-specific scope when the assignment is scoped to an app. The scope of an assignment determines the set of resources for which the principal has been granted access. App scopes are scopes that are defined and understood by this application only. Use / for tenant-wide app scopes. Use directoryScopeId to limit the scope to particular directory objects, for example, administrative units. Supports $filter (eq, ne, and on null values)."
  type        = string
  default     = null
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

variable "directory_scope_id" {
  description = "Identifier of the directory object representing the scope of the assignment. The scope of an assignment determines the set of resources for which the principal has been granted access. Directory scopes are shared scopes stored in the directory that are understood by multiple applications. Use / for tenant-wide scope. Use appScopeId to limit the scope to an application only. Supports $filter (eq, ne, and on null values)."
  type        = string
  default     = null
}

variable "is_validation_only" {
  description = "Determines whether the call is a validation or an actual call. Only set this property if you want to check whether an activation is subject to additional rules like MFA before actually submitting the request."
  type        = bool
  default     = null
}

variable "justification" {
  description = "A message provided by users and administrators when create they create the unifiedRoleAssignmentScheduleRequest object."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRoleAssignmentScheduleRequest"
  nullable    = false
}

variable "principal" {
  description = "The principal that's getting a role assignment through the request. Supports $expand and $select nested in $expand for id only."
  type        = any
  default     = null
}

variable "principal_id" {
  description = "Identifier of the principal that has been granted the assignment. Can be a user, role-assignable group, or a service principal. Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "role_definition" {
  description = "Detailed information for the unifiedRoleDefinition object that is referenced through the roleDefinitionId property. Supports $expand and $select nested in $expand."
  type        = any
  default     = null
}

variable "role_definition_id" {
  description = "Identifier of the unifiedRoleDefinition object that is being assigned to the principal. Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "schedule_info" {
  description = "The period of the role assignment. Recurring schedules are currently unsupported."
  type        = any
  default     = null
}

variable "status" {
  description = "The status of the request. Not nullable. The possible values are: Canceled, Denied, Failed, Granted, PendingAdminDecision, PendingApproval, PendingProvisioning, PendingScheduleCreation, Provisioned, Revoked, and ScheduleCreated. Not nullable."
  type        = string
  default     = null
}

variable "target_schedule" {
  description = "The schedule for an eligible role assignment that is referenced through the targetScheduleId property. Supports $expand and $select nested in $expand."
  type        = any
  default     = null
}

variable "target_schedule_id" {
  description = "Identifier of the schedule object that's linked to the assignment request. Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "ticket_info" {
  description = "Ticket details linked to the role assignment request including details of the ticket number and ticket system."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["appScope", "directoryScope", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
