variable "aggregated_date_time" {
  description = "The aggregated day for which the summary applies to. This property will always represent the entire day. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "change_password_self_service_count" {
  description = "The number of self-service password changes that occurred during this window."
  type        = number
  default     = null
  sensitive   = true
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userPasswordResetsAndChangesSummary"
  nullable    = false
}

variable "password_resets_by_admin_count" {
  description = "The number of admin-triggered password resets that occurred during this window."
  type        = number
  default     = null
  sensitive   = true
}

variable "password_resets_self_service_count" {
  description = "The number of self-service password resets that occurred during this window."
  type        = number
  default     = null
  sensitive   = true
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
