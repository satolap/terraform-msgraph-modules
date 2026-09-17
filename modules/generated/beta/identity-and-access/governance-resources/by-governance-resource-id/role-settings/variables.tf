variable "governance_resource_id" {
  description = "The unique identifier of governanceResource"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.governance_resource_id)) > 0
    error_message = "governance_resource_id must not be empty."
  }
}

variable "admin_eligible_settings" {
  description = "The rule settings that are evaluated when an administrator tries to add an eligible role assignment."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.governanceRuleSetting")
    ruleIdentifier = optional(string)
    setting        = optional(string)
  }))
  default = null
}

variable "admin_member_settings" {
  description = "The rule settings that are evaluated when an administrator tries to add a direct member role assignment."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.governanceRuleSetting")
    ruleIdentifier = optional(string)
    setting        = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.governanceRoleSetting"
  nullable    = false
}

variable "resource_id" {
  description = "Required. The id of the resource that the role setting is associated with."
  type        = string
  default     = null
}

variable "role_definition_id" {
  description = "Required. The id of the role definition that the role setting is associated with."
  type        = string
  default     = null
}

variable "user_eligible_settings" {
  description = "The rule settings that are evaluated when a user tries to add an eligible role assignment. The setting is not supported for now."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.governanceRuleSetting")
    ruleIdentifier = optional(string)
    setting        = optional(string)
  }))
  default = null
}

variable "user_member_settings" {
  description = "The rule settings that are evaluated when a user tries to activate his role assignment."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.governanceRuleSetting")
    ruleIdentifier = optional(string)
    setting        = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "isDefault", "lastUpdatedBy", "lastUpdatedDateTime", "resource", "roleDefinition"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
