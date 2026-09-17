variable "created_date_time" {
  description = "The date and time (UTC) for when the summary was aggregated for. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "multi_factor_sign_ins" {
  description = "The total number of MFA sign-ins for the given day."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userMfaSignInSummary"
  nullable    = false
}

variable "single_factor_sign_ins" {
  description = "The total number of non-MFA sign ins for the given day."
  type        = number
  default     = null
}

variable "total_sign_ins" {
  description = "The total number of sign-ins for the given day."
  type        = number
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
