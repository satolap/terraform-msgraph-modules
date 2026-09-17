variable "rbac_application_id" {
  description = "The unique identifier of rbacApplication"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.rbac_application_id)) > 0
    error_message = "rbac_application_id must not be empty."
  }
}

variable "action" {
  description = "Represents the type of operation on the role eligibility request. The possible values are: AdminAssign: For administrators to assign eligible roles to principals.AdminRemove: For administrators to remove eligible roles from principals. AdminUpdate: For administrators to change existing role eligibilities.AdminExtend: For administrators to extend expiring role eligibilities.AdminRenew: For administrators to renew expired eligibilities.UserAdd: For users to activate their eligible assignments.UserRemove: For users to deactivate their active eligible assignments.UserExtend: For users to request to extend their expiring eligible assignments.UserRenew: For users to request to renew their expired eligible assignments."
  type        = string
  default     = null
}

variable "app_scope_id" {
  description = "Identifier of the app-specific scope when the role eligibility is scoped to an app. The scope of a role eligibility determines the set of resources for which the principal is eligible to access. App scopes are scopes that are defined and understood by this application only. Use / for tenant-wide app scopes. Use directoryScopeId to limit the scope to particular directory objects, for example, administrative units. Supports $filter (eq, ne, and on null values)."
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
  description = "Identifier of the directory object representing the scope of the role eligibility. The scope of a role eligibility determines the set of resources for which the principal has been granted access. Directory scopes are shared scopes stored in the directory that are understood by multiple applications. Use / for tenant-wide scope. Use appScopeId to limit the scope to an application only. Supports $filter (eq, ne, and on null values)."
  type        = string
  default     = null
}

variable "is_validation_only" {
  description = "Determines whether the call is a validation or an actual call. Only set this property if you want to check whether an activation is subject to additional rules like MFA before actually submitting the request."
  type        = bool
  default     = null
}

variable "justification" {
  description = "A message provided by users and administrators when create they create the unifiedRoleEligibilityScheduleRequest object."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRoleEligibilityScheduleRequest"
  nullable    = false
}

variable "principal" {
  description = "The principal that's getting a role eligibility through the request. Supports $expand."
  type        = any
  default     = null
}

variable "principal_id" {
  description = "Identifier of the principal that has been granted the role eligibility. Can be a user or a role-assignable group. You can grant only active assignments service principals. Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "role_definition" {
  description = "Detailed information for the unifiedRoleDefinition object that is referenced through the roleDefinitionId property. Supports $expand."
  type        = any
  default     = null
}

variable "role_definition_id" {
  description = "Identifier of the unifiedRoleDefinition object that is being assigned to the principal. Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "schedule_info" {
  description = "The period of the role eligibility. Recurring schedules are currently unsupported."
  type        = any
  default     = null
}

variable "status" {
  description = "The status of the request. Not nullable. The possible values are: Canceled, Denied, Failed, Granted, PendingAdminDecision, PendingApproval, PendingProvisioning, PendingScheduleCreation, Provisioned, Revoked, and ScheduleCreated. Not nullable."
  type        = string
  default     = null
}

variable "target_schedule" {
  description = "The schedule for a role eligibility that is referenced through the targetScheduleId property. Supports $expand."
  type        = any
  default     = null
}

variable "target_schedule_id" {
  description = "Identifier of the schedule object that's linked to the eligibility request. Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "ticket_info" {
  description = "Ticket details linked to the role eligibility request including details of the ticket number and ticket system. Optional."
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
