variable "created_by" {
  description = "The userPrincipalName of the user or identity that created the control configuration."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time the control configuration was created."
  type        = string
  default     = null
}

variable "is_enabled" {
  description = "Determines whether or not the control configuration is enabled."
  type        = bool
  default     = null
}

variable "modified_by" {
  description = "The userPrincipalName of the user or identity that modified the control configuration."
  type        = string
  default     = null
}

variable "modified_date_time" {
  description = "The date and time the control configuration was modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.controlConfiguration"
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
