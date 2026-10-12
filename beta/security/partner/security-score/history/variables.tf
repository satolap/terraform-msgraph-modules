variable "compliant_requirements_count" {
  description = "The number of compliant security requirements at the time."
  type        = number
  default     = null
}

variable "created_date_time" {
  description = "The date the history entry was created."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.partner.security.securityScoreHistory"
  nullable    = false
}

variable "score" {
  description = "The score recorded at the time."
  type        = any
  default     = null
}

variable "total_requirements_count" {
  description = "The total number of requirements at the time."
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
