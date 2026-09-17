variable "display_name" {
  description = "The display name of the provider managed by PIM."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.privilegedAccess"
  nullable    = false
}

variable "resources" {
  description = "A collection of resources for the provider."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.governanceResource")
    displayName        = optional(string)
    externalId         = optional(string)
    registeredDateTime = optional(string)
    registeredRoot     = optional(string)
    roleAssignmentRequests = optional(list(object({
      odata_type                     = optional(string, "#microsoft.graph.governanceRoleAssignmentRequest")
      assignmentState                = optional(string)
      linkedEligibleRoleAssignmentId = optional(string)
      reason                         = optional(string)
      resourceId                     = optional(string)
      roleDefinitionId               = optional(string)
      schedule                       = optional(any)
      status                         = optional(any)
      subjectId                      = optional(string)
      type                           = optional(string)
    })))
    roleAssignments = optional(list(object({
      odata_type                     = optional(string, "#microsoft.graph.governanceRoleAssignment")
      assignmentState                = optional(string)
      endDateTime                    = optional(string)
      externalId                     = optional(string)
      linkedEligibleRoleAssignmentId = optional(string)
      memberType                     = optional(string)
      resourceId                     = optional(string)
      roleDefinitionId               = optional(string)
      startDateTime                  = optional(string)
      status                         = optional(string)
      subjectId                      = optional(string)
    })))
    roleDefinitions = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.governanceRoleDefinition")
      displayName = optional(string)
      externalId  = optional(string)
      resourceId  = optional(string)
      roleSetting = optional(any)
      templateId  = optional(string)
    })))
    roleSettings = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.governanceRoleSetting")
      adminEligibleSettings = optional(any)
      adminMemberSettings   = optional(any)
      resourceId            = optional(string)
      roleDefinitionId      = optional(string)
      userEligibleSettings  = optional(any)
      userMemberSettings    = optional(any)
    })))
    status = optional(string)
    type   = optional(string)
  }))
  default = null
}

variable "role_assignment_requests" {
  description = "A collection of role assignment requests for the provider."
  type = list(object({
    odata_type                     = optional(string, "#microsoft.graph.governanceRoleAssignmentRequest")
    assignmentState                = optional(string)
    linkedEligibleRoleAssignmentId = optional(string)
    reason                         = optional(string)
    resourceId                     = optional(string)
    roleDefinitionId               = optional(string)
    schedule                       = optional(any)
    status                         = optional(any)
    subjectId                      = optional(string)
    type                           = optional(string)
  }))
  default = null
}

variable "role_assignments" {
  description = "A collection of role assignments for the provider."
  type = list(object({
    odata_type                     = optional(string, "#microsoft.graph.governanceRoleAssignment")
    assignmentState                = optional(string)
    endDateTime                    = optional(string)
    externalId                     = optional(string)
    linkedEligibleRoleAssignmentId = optional(string)
    memberType                     = optional(string)
    resourceId                     = optional(string)
    roleDefinitionId               = optional(string)
    startDateTime                  = optional(string)
    status                         = optional(string)
    subjectId                      = optional(string)
  }))
  default = null
}

variable "role_definitions" {
  description = "A collection of role definitions for the provider."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.governanceRoleDefinition")
    displayName = optional(string)
    externalId  = optional(string)
    resourceId  = optional(string)
    roleSetting = optional(any)
    templateId  = optional(string)
  }))
  default = null
}

variable "role_settings" {
  description = "A collection of role settings for the provider."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.governanceRoleSetting")
    adminEligibleSettings = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.governanceRuleSetting")
      ruleIdentifier = optional(string)
      setting        = optional(string)
    })))
    adminMemberSettings = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.governanceRuleSetting")
      ruleIdentifier = optional(string)
      setting        = optional(string)
    })))
    resourceId       = optional(string)
    roleDefinitionId = optional(string)
    userEligibleSettings = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.governanceRuleSetting")
      ruleIdentifier = optional(string)
      setting        = optional(string)
    })))
    userMemberSettings = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.governanceRuleSetting")
      ruleIdentifier = optional(string)
      setting        = optional(string)
    })))
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
