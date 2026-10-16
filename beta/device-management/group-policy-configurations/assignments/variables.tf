variable "group_policy_configuration_id" {
  description = "The unique identifier of groupPolicyConfiguration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_policy_configuration_id)) > 0
    error_message = "group_policy_configuration_id must not be empty."
  }
}

variable "last_modified_date_time" {
  description = "The date and time the entity was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupPolicyConfigurationAssignment"
  nullable    = false
}

variable "target" {
  description = "The type of groups targeted the group policy configuration."
  type        = any
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
