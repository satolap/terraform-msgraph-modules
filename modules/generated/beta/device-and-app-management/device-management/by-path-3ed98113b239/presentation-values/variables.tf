variable "group_policy_configuration_id" {
  description = "The unique identifier of groupPolicyConfiguration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_policy_configuration_id)) > 0
    error_message = "group_policy_configuration_id must not be empty."
  }
}

variable "group_policy_definition_value_id" {
  description = "The unique identifier of groupPolicyDefinitionValue"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_policy_definition_value_id)) > 0
    error_message = "group_policy_definition_value_id must not be empty."
  }
}

variable "created_date_time" {
  description = "The date and time the object was created."
  type        = string
  default     = null
}

variable "definition_value" {
  description = "The group policy definition value associated with the presentation value."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time the object was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupPolicyPresentationValue"
  nullable    = false
}

variable "presentation" {
  description = "The group policy presentation associated with the presentation value."
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
