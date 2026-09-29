variable "unified_role_management_policy_id" {
  description = "The unique identifier of unifiedRoleManagementPolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.unified_role_management_policy_id)) > 0
    error_message = "unified_role_management_policy_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.unifiedRoleManagementPolicyApprovalRule", "#microsoft.graph.unifiedRoleManagementPolicyAuthenticationContextRule", "#microsoft.graph.unifiedRoleManagementPolicyEnablementRule", "#microsoft.graph.unifiedRoleManagementPolicyExpirationRule", "#microsoft.graph.unifiedRoleManagementPolicyNotificationRule"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "target" {
  description = "Not implemented. Defines details of scope that's targeted by role management policy rule. The details can include the principal type, the role assignment type, and actions affecting a role. Supports $filter (eq, ne)."
  type = object({
    odata_type          = optional(string, "#microsoft.graph.unifiedRoleManagementPolicyRuleTarget")
    caller              = optional(string)
    enforcedSettings    = optional(list(string))
    inheritableSettings = optional(list(string))
    level               = optional(string)
    operations          = optional(list(string))
    targetObjects       = optional(any)
  })
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
