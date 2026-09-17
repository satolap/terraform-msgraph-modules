variable "aggregated_event_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "app_display_name" {
  description = "Name of the application that the user signed in to."
  type        = string
  default     = null
}

variable "app_id" {
  description = "ID of the application that the user signed in to."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.applicationSignInDetailedSummary"
  nullable    = false
}

variable "sign_in_count" {
  description = "Count of sign-ins made by the application."
  type        = number
  default     = null
}

variable "status" {
  description = "Details of the sign-in status."
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
