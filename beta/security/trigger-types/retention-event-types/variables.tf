variable "created_by" {
  description = "The user who created the retentionEventType."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date time when the retentionEventType was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Optional information about the event type."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Name of the event type."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "The user who last modified the retentionEventType."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The latest date time when the retentionEventType was modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.retentionEventType"
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
