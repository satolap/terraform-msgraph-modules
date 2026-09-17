variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRoleManagementPolicyAssignment"
  nullable    = false
}

variable "policy" {
  description = "The policy that's associated with a policy assignment. Supports $expand and a nested $expand of the rules and effectiveRules relationships for the policy."
  type        = any
  default     = null
}

variable "policy_id" {
  description = "The id of the policy. Inherited from entity."
  type        = string
  default     = null
}

variable "role_definition_id" {
  description = "For Microsoft Entra roles policy, it's the identifier of the role definition object where the policy applies. For PIM for Groups membership and ownership, it's either member or owner. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "scope_id" {
  description = "The identifier of the scope where the policy is assigned. Can be / for the tenant or a group ID. Required."
  type        = string
  default     = null
}

variable "scope_type" {
  description = "The type of the scope where the policy is assigned. One of Directory, DirectoryRole, Group. Required."
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
