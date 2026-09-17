variable "description" {
  description = "Description for the policy."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name for the policy."
  type        = string
  default     = null
}

variable "effective_rules" {
  description = "The list of effective rules like approval rules and expiration rules evaluated based on inherited referenced rules. For example, if there is a tenant-wide policy to enforce enabling an approval rule, the effective rule will be to enable approval even if the policy has a rule to disable approval. Supports $expand."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.unifiedRoleManagementPolicyRule")
    target     = optional(any)
  }))
  default = null
}

variable "is_organization_default" {
  description = "This can only be set to true for a single tenant-wide policy which will apply to all scopes and roles. Set the scopeId to / and scopeType to Directory. Supports $filter (eq, ne)."
  type        = bool
  default     = null
}

variable "last_modified_by" {
  description = "The identity who last modified the role setting."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The time when the role setting was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRoleManagementPolicy"
  nullable    = false
}

variable "rules" {
  description = "The collection of rules like approval rules and expiration rules. Supports $expand."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.unifiedRoleManagementPolicyRule")
    target     = optional(any)
  }))
  default = null
}

variable "scope_id" {
  description = "The identifier of the scope where the policy is created. Can be / for the tenant or a group ID. Required."
  type        = string
  default     = null
}

variable "scope_type" {
  description = "The type of the scope where the policy is created. One of Directory, DirectoryRole, Group. Required."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
