variable "additional_information" {
  description = "A set of string key and string value pairs which provides additional information on the Troubleshooting event"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "correlation_id" {
  description = "Id used for tracing the failure in the service."
  type        = string
  default     = null
}

variable "event_date_time" {
  description = "Time when the event occurred ."
  type        = string
  default     = null
}

variable "event_name" {
  description = "Event Name corresponding to the Troubleshooting Event. It is an Optional field"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementTroubleshootingEvent"
  nullable    = false
}

variable "troubleshooting_error_details" {
  description = "Object containing detailed information about the error and its remediation."
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
