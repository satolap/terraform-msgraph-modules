variable "category" {
  description = "The category of impacting process."
  type        = string
  default     = null
}

variable "description" {
  description = "The description of process."
  type        = string
  default     = null
}

variable "device_id" {
  description = "The unique identifier of the impacted device."
  type        = string
  default     = null
}

variable "impact_value" {
  description = "The impact value of the process. Valid values 0 to 1.79769313486232E+308"
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsImpactingProcess"
  nullable    = false
}

variable "process_name" {
  description = "The process name."
  type        = string
  default     = null
}

variable "publisher" {
  description = "The publisher of the process."
  type        = string
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
