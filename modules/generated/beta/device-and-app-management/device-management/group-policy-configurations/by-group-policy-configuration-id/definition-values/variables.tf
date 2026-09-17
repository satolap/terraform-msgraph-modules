variable "group_policy_configuration_id" {
  description = "The unique identifier of groupPolicyConfiguration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_policy_configuration_id)) > 0
    error_message = "group_policy_configuration_id must not be empty."
  }
}

variable "configuration_type" {
  description = "Group Policy Configuration Type"
  type        = string
  default     = null

  validation {
    condition     = var.configuration_type == null ? true : contains(["policy", "preference"], var.configuration_type)
    error_message = "configuration_type must be one of the documented enum values."
  }
}

variable "created_date_time" {
  description = "The date and time the object was created."
  type        = string
  default     = null
}

variable "definition" {
  description = "The associated group policy definition with the value."
  type        = any
  default     = null
}

variable "enabled" {
  description = "Enables or disables the associated group policy definition."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time the entity was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupPolicyDefinitionValue"
  nullable    = false
}

variable "presentation_values" {
  description = "The associated group policy presentation values with the definition value."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.groupPolicyPresentationValue")
    createdDateTime      = optional(string)
    definitionValue      = optional(any)
    lastModifiedDateTime = optional(string)
    presentation         = optional(any)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
