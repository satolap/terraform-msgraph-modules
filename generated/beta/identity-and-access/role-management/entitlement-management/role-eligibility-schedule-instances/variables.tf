variable "app_scope_id" {
  description = "Identifier of the app-specific scope when the assignment or role eligibility is scoped to an app. The scope of an assignment or role eligibility determines the set of resources for which the principal has been granted access. App scopes are scopes that are defined and understood by this application only. Use / for tenant-wide app scopes. Use directoryScopeId to limit the scope to particular directory objects, for example, administrative units."
  type        = string
  default     = null
}

variable "directory_scope_id" {
  description = "Identifier of the directory object representing the scope of the assignment or role eligibility. The scope of an assignment or role eligibility determines the set of resources for which the principal has been granted access. Directory scopes are shared scopes stored in the directory that are understood by multiple applications. Use / for tenant-wide scope. Use appScopeId to limit the scope to an application only."
  type        = string
  default     = null
}

variable "end_date_time" {
  description = "Time that the roleEligibilityScheduleInstance will expire."
  type        = string
  default     = null
}

variable "member_type" {
  description = "Membership type of the assignment. It can either be Inherited, Direct, or Group."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRoleEligibilityScheduleInstance"
  nullable    = false
}

variable "principal" {
  description = "The principal that's getting a role assignment or role eligibility through the request."
  type        = any
  default     = null
}

variable "principal_id" {
  description = "Identifier of the principal that has been granted the role assignment or that's eligible for a role."
  type        = string
  default     = null
}

variable "role_definition" {
  description = "Detailed information for the roleDefinition object that is referenced through the roleDefinitionId property."
  type        = any
  default     = null
}

variable "role_definition_id" {
  description = "Identifier of the unifiedRoleDefinition object that is being assigned to the principal or that the principal is eligible for."
  type        = string
  default     = null
}

variable "role_eligibility_schedule_id" {
  description = "Identifier of the parent roleEligibilitySchedule for this instance."
  type        = string
  default     = null
}

variable "start_date_time" {
  description = "Time that the roleEligibilityScheduleInstance will start."
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
