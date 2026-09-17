variable "custom_security_attribute_definition_id" {
  description = "The unique identifier of customSecurityAttributeDefinition"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.custom_security_attribute_definition_id)) > 0
    error_message = "custom_security_attribute_definition_id must not be empty."
  }
}

variable "is_active" {
  description = "Indicates whether the predefined value is active or deactivated. If set to false, this predefined value can't be assigned to any more supported directory objects."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.allowedValue"
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
