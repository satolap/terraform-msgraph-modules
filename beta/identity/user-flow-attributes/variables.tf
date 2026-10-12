variable "data_type" {
  description = "Microsoft Graph dataType property."
  type        = string
  default     = null

  validation {
    condition     = var.data_type == null ? true : contains(["string", "boolean", "int64", "stringCollection", "dateTime", "unknownFutureValue"], var.data_type)
    error_message = "data_type must be one of the documented enum values."
  }
}

variable "description" {
  description = "The description of the user flow attribute that's shown to the user at the time of sign up."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the user flow attribute.  Supports $filter (eq, ne)."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.identityUserFlowAttribute"
  nullable    = false
}

variable "user_flow_attribute_type" {
  description = "Microsoft Graph userFlowAttributeType property."
  type        = string
  default     = null

  validation {
    condition     = var.user_flow_attribute_type == null ? true : contains(["builtIn", "custom", "required", "unknownFutureValue"], var.user_flow_attribute_type)
    error_message = "user_flow_attribute_type must be one of the documented enum values."
  }
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
