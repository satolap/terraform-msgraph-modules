variable "classify_as" {
  description = "Specifies how incoming messages from a specific sender should always be classified as. The possible values are: focused, other."
  type        = any
  default     = null

  validation {
    condition     = var.classify_as == null ? true : contains(["focused", "other"], var.classify_as)
    error_message = "classify_as must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.inferenceClassificationOverride"
  nullable    = false
}

variable "sender_email_address" {
  description = "The email address information of the sender for whom the override is created."
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
