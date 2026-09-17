variable "arity" {
  description = "Microsoft Graph arity property."
  type        = string
  default     = null

  validation {
    condition     = var.arity == null ? true : contains(["Binary", "Unary"], var.arity)
    error_message = "arity must be one of the documented enum values."
  }
}

variable "multivalued_comparison_type" {
  description = "Microsoft Graph multivaluedComparisonType property."
  type        = string
  default     = null

  validation {
    condition     = var.multivalued_comparison_type == null ? true : contains(["All", "Any"], var.multivalued_comparison_type)
    error_message = "multivalued_comparison_type must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.filterOperatorSchema"
  nullable    = false
}

variable "supported_attribute_types" {
  description = "Attribute types supported by the operator. The possible values are: Boolean, Binary, Reference, Integer, String."
  type        = list(string)
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
