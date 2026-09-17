variable "rbac_application_id" {
  description = "The unique identifier of rbacApplication"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.rbac_application_id)) > 0
    error_message = "rbac_application_id must not be empty."
  }
}

variable "activated_using" {
  description = "If the request is from an eligible administrator to activate a role, this parameter shows the related eligible assignment for that activation. Otherwise, it's null. Supports $expand."
  type        = any
  default     = null
}

variable "app_scope_id" {
  description = "Identifier of the app-specific scope when the assignment or eligibility is scoped to an app. The scope of an assignment or eligibility determines the set of resources for which the principal has been granted access. App scopes are scopes that are defined and understood by this application only. Use / for tenant-wide app scopes. Use directoryScopeId to limit the scope to particular directory objects, for example, administrative units."
  type        = string
  default     = null
}

variable "assignment_type" {
  description = "The type of the assignment that can either be Assigned or Activated. Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "When the schedule was created."
  type        = string
  default     = null
}

variable "created_using" {
  description = "Identifier of the object through which this schedule was created."
  type        = string
  default     = null
}

variable "directory_scope_id" {
  description = "Identifier of the directory object representing the scope of the assignment or eligibility. The scope of an assignment or eligibility determines the set of resources for which the principal has been granted access. Directory scopes are shared scopes stored in the directory that are understood by multiple applications. Use / for tenant-wide scope. Use appScopeId to limit the scope to an application only."
  type        = string
  default     = null
}

variable "member_type" {
  description = "How the assignment is inherited. It can either be Inherited, Direct, or Group. It can further imply whether the unifiedRoleAssignmentSchedule can be managed by the caller. Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "modified_date_time" {
  description = "When the schedule was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRoleAssignmentSchedule"
  nullable    = false
}

variable "principal" {
  description = "The principal that's getting a role assignment or that's eligible for a role through the request."
  type        = any
  default     = null
}

variable "principal_id" {
  description = "Identifier of the principal that has been granted the role assignment or eligibility."
  type        = string
  default     = null
}

variable "role_definition" {
  description = "Detailed information for the roleDefinition object that is referenced through the roleDefinitionId property."
  type        = any
  default     = null
}

variable "role_definition_id" {
  description = "Identifier of the unifiedRoleDefinition object that is being assigned to the principal or that a principal is eligible for."
  type        = string
  default     = null
}

variable "schedule_info" {
  description = "The period of the role assignment. It can represent a single occurrence or multiple recurrences."
  type        = any
  default     = null
}

variable "status" {
  description = "The status of the role assignment or eligibility request."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["appScope", "directoryScope", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
