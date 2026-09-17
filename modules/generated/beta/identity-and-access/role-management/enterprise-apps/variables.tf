variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.rbacApplication"
  nullable    = false
}

variable "resource_namespaces" {
  description = "Microsoft Graph resourceNamespaces property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.unifiedRbacResourceNamespace")
    name       = optional(string)
    resourceActions = optional(list(object({
      odata_type                      = optional(string, "#microsoft.graph.unifiedRbacResourceAction")
      actionVerb                      = optional(string)
      authenticationContext           = optional(any)
      authenticationContextId         = optional(string)
      description                     = optional(string)
      isAuthenticationContextSettable = optional(bool)
      name                            = optional(string)
      resourceScope                   = optional(any)
      resourceScopeId                 = optional(string)
    })))
  }))
  default = null
}

variable "role_assignment_approvals" {
  description = "Microsoft Graph roleAssignmentApprovals property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.approval")
    steps = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.approvalStep")
      justification = optional(string)
      reviewResult  = optional(string)
    })))
  }))
  default = null
}

variable "role_assignment_schedule_instances" {
  description = "Microsoft Graph roleAssignmentScheduleInstances property."
  type = list(object({
    odata_type               = optional(string, "#microsoft.graph.unifiedRoleAssignmentScheduleInstance")
    activatedUsing           = optional(any)
    appScopeId               = optional(string)
    assignmentType           = optional(string)
    directoryScopeId         = optional(string)
    endDateTime              = optional(string)
    memberType               = optional(string)
    principal                = optional(any)
    principalId              = optional(string)
    roleAssignmentOriginId   = optional(string)
    roleAssignmentScheduleId = optional(string)
    roleDefinition           = optional(any)
    roleDefinitionId         = optional(string)
    startDateTime            = optional(string)
  }))
  default = null
}

variable "role_assignment_schedule_requests" {
  description = "Microsoft Graph roleAssignmentScheduleRequests property."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.unifiedRoleAssignmentScheduleRequest")
    action            = optional(string)
    activatedUsing    = optional(any)
    appScopeId        = optional(string)
    approvalId        = optional(string)
    completedDateTime = optional(string)
    createdBy         = optional(any)
    createdDateTime   = optional(string)
    customData        = optional(string)
    directoryScopeId  = optional(string)
    isValidationOnly  = optional(bool)
    justification     = optional(string)
    principal         = optional(any)
    principalId       = optional(string)
    roleDefinition    = optional(any)
    roleDefinitionId  = optional(string)
    scheduleInfo      = optional(any)
    status            = optional(string)
    targetSchedule    = optional(any)
    targetScheduleId  = optional(string)
    ticketInfo        = optional(any)
  }))
  default = null
}

variable "role_assignment_schedules" {
  description = "Microsoft Graph roleAssignmentSchedules property."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.unifiedRoleAssignmentSchedule")
    activatedUsing   = optional(any)
    appScopeId       = optional(string)
    assignmentType   = optional(string)
    createdDateTime  = optional(string)
    createdUsing     = optional(string)
    directoryScopeId = optional(string)
    memberType       = optional(string)
    modifiedDateTime = optional(string)
    principal        = optional(any)
    principalId      = optional(string)
    roleDefinition   = optional(any)
    roleDefinitionId = optional(string)
    scheduleInfo     = optional(any)
    status           = optional(string)
  }))
  default = null
}

variable "role_assignments" {
  description = "Microsoft Graph roleAssignments property."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.unifiedRoleAssignment")
    appScopeId              = optional(string)
    condition               = optional(string)
    directoryScopeId        = optional(string)
    principalId             = optional(string)
    principalOrganizationId = optional(string)
    resourceScope           = optional(string)
    roleDefinition          = optional(any)
  }))
  default = null
}

variable "role_definitions" {
  description = "Microsoft Graph roleDefinitions property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.unifiedRoleDefinition")
  }))
  default = null
}

variable "role_eligibility_schedule_instances" {
  description = "Microsoft Graph roleEligibilityScheduleInstances property."
  type = list(object({
    odata_type                = optional(string, "#microsoft.graph.unifiedRoleEligibilityScheduleInstance")
    appScopeId                = optional(string)
    directoryScopeId          = optional(string)
    endDateTime               = optional(string)
    memberType                = optional(string)
    principal                 = optional(any)
    principalId               = optional(string)
    roleDefinition            = optional(any)
    roleDefinitionId          = optional(string)
    roleEligibilityScheduleId = optional(string)
    startDateTime             = optional(string)
  }))
  default = null
}

variable "role_eligibility_schedule_requests" {
  description = "Microsoft Graph roleEligibilityScheduleRequests property."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.unifiedRoleEligibilityScheduleRequest")
    action            = optional(string)
    appScopeId        = optional(string)
    approvalId        = optional(string)
    completedDateTime = optional(string)
    createdBy         = optional(any)
    createdDateTime   = optional(string)
    customData        = optional(string)
    directoryScopeId  = optional(string)
    isValidationOnly  = optional(bool)
    justification     = optional(string)
    principal         = optional(any)
    principalId       = optional(string)
    roleDefinition    = optional(any)
    roleDefinitionId  = optional(string)
    scheduleInfo      = optional(any)
    status            = optional(string)
    targetSchedule    = optional(any)
    targetScheduleId  = optional(string)
    ticketInfo        = optional(any)
  }))
  default = null
}

variable "role_eligibility_schedules" {
  description = "Microsoft Graph roleEligibilitySchedules property."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.unifiedRoleEligibilitySchedule")
    appScopeId       = optional(string)
    createdDateTime  = optional(string)
    createdUsing     = optional(string)
    directoryScopeId = optional(string)
    memberType       = optional(string)
    modifiedDateTime = optional(string)
    principal        = optional(any)
    principalId      = optional(string)
    roleDefinition   = optional(any)
    roleDefinitionId = optional(string)
    scheduleInfo     = optional(any)
    status           = optional(string)
  }))
  default = null
}

variable "transitive_role_assignments" {
  description = "Microsoft Graph transitiveRoleAssignments property."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.unifiedRoleAssignment")
    appScopeId              = optional(string)
    condition               = optional(string)
    directoryScopeId        = optional(string)
    principalId             = optional(string)
    principalOrganizationId = optional(string)
    resourceScope           = optional(string)
    roleDefinition          = optional(any)
  }))
  default = null
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
