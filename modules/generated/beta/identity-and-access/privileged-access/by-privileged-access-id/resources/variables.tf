variable "privileged_access_id" {
  description = "The unique identifier of privilegedAccess"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.privileged_access_id)) > 0
    error_message = "privileged_access_id must not be empty."
  }
}

variable "display_name" {
  description = "The display name of the resource."
  type        = string
  default     = null
}

variable "external_id" {
  description = "The external id of the resource, representing its original id in the external system. For example, a subscription resource's external id can be '/subscriptions/c14ae696-5e0c-4e5d-88cc-bef6637737ac'."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.governanceResource"
  nullable    = false
}

variable "registered_date_time" {
  description = "Represents the date time when the resource is registered in PIM."
  type        = string
  default     = null
}

variable "registered_root" {
  description = "The externalId of the resource's root scope that is registered in PIM. The root scope can be the parent, grandparent, or higher ancestor resources."
  type        = string
  default     = null
}

variable "role_assignment_requests" {
  description = "The collection of role assignment requests for the resource."
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
  description = "The collection of role assignments for the resource."
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
  description = "The collection of role definitions for the resource."
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
  description = "The collection of role settings for the resource."
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

variable "status" {
  description = "The status of a given resource. For example, it could represent whether the resource is locked or not (values: Active/Locked). Note: This property may be extended in the future to support more scenarios."
  type        = string
  default     = null
}

variable "type" {
  description = "Required. Resource type. For example, for Azure resources, the type could be 'Subscription', 'ResourceGroup', 'Microsoft.Sql/server', etc."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "parent"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
