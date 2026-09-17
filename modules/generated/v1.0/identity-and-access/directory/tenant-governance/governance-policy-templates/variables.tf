variable "created_date_time" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "delegated_administration_role_assignments" {
  description = "Microsoft Graph delegatedAdministrationRoleAssignments property."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.delegatedAdministrationRoleAssignment")
    group            = optional(any)
    groupDisplayName = optional(string)
    roleTemplates = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.roleTemplate")
      id         = optional(string)
      name       = optional(string)
    })))
  }))
  default = null
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "governed_tenant_can_terminate" {
  description = "Microsoft Graph governedTenantCanTerminate property."
  type        = bool
  default     = null
}

variable "graph_version" {
  description = "Microsoft Graph version property."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "multi_tenant_applications_to_provision" {
  description = "Microsoft Graph multiTenantApplicationsToProvision property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.multiTenantApplicationsToProvision")
    appId       = optional(string)
    displayName = optional(string)
    objectId    = optional(string)
    requiredResourceAccesses = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.applicationsRequiredResourceAccess")
      permissions   = optional(any)
      resourceAppId = optional(string)
    })))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.tenantGovernancePolicyTemplate"
  nullable    = false
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
