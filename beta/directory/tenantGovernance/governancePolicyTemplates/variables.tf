variable "createdDateTime" {
  description = "The date and time when the template was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. Supports $filter (lt, le, gt, ge, eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "delegatedAdministrationRoleAssignments" {
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

variable "displayName" {
  description = "The display name of the policy template. Supports $filter (eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "governedTenantCanTerminate" {
  description = "Not implemented."
  type        = bool
  default     = null
}

variable "graph_version" {
  description = "The version of the policy template. Version count increased by 1 when updated. Supports $filter (lt, le, gt, ge, eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "lastModifiedDateTime" {
  description = "The date and time when the template was last modified. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. Supports $filter (lt, le, gt, ge, eq, ne) and $orderBy."
  type        = string
  default     = null
}

variable "multiTenantApplicationsToProvision" {
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

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
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
