variable "color" {
  description = "A pre-set color constant that characterizes a category, and that is mapped to one of 25 predefined colors. For more details, see the following note."
  type        = any
  default     = null

  validation {
    condition     = var.color == null ? true : contains(["none", "preset0", "preset1", "preset2", "preset3", "preset4", "preset5", "preset6", "preset7", "preset8", "preset9", "preset10", "preset11", "preset12", "preset13", "preset14", "preset15", "preset16", "preset17", "preset18", "preset19", "preset20", "preset21", "preset22", "preset23", "preset24"], var.color)
    error_message = "color must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.outlookCategory"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["displayName", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
