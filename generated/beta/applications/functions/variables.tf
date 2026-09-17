variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.attributeMappingFunctionSchema"
  nullable    = false
}

variable "parameters" {
  description = "Collection of function parameters."
  type = list(object({
    odata_type               = optional(string, "#microsoft.graph.attributeMappingParameterSchema")
    allowMultipleOccurrences = optional(bool)
    name                     = optional(string)
    required                 = optional(bool)
    type                     = optional(string)
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
