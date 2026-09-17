variable "created_by" {
  description = "Represents the user who created the filePlanDescriptorTemplate column."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Represents the date and time in which the filePlanDescriptorTemplate is created."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Unique string that defines a filePlanDescriptorTemplate name."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.authorityTemplate"
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
