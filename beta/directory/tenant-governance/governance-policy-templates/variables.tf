variable "created_date_time" {
  description = "The date and time when the template was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. Supports $filter (lt, le, gt, ge, eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "delegated_administration_role_assignments" {
  description = "A collection of delegated administration role assignments to be applied in the governed tenant when the governance relationship is established."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.delegatedAdministrationRoleAssignment")
    group      = optional(any)
    roleTemplates = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.roleTemplate")
      id         = optional(string)
      name       = optional(string)
    })))
  }))
  default = null
}

variable "description" {
  description = "A description of the policy template. Supports $filter (eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the policy template. Supports $filter (eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "governed_tenant_can_terminate" {
  description = "Not implemented."
  type        = bool
  default     = null
}

variable "graph_version" {
  description = "The version of the policy template. Version count increased by 1 when updated. Supports $filter (lt, le, gt, ge, eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the template was last modified. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. Supports $filter (lt, le, gt, ge, eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "multi_tenant_applications_to_provision" {
  description = "A collection of multi-tenant applications to be provisioned in the governed tenant when the governance relationship is established."
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
