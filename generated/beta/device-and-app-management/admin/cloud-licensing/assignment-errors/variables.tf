variable "assigned_to" {
  description = "Microsoft Graph assignedTo property."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  })
  default = null
}

variable "code" {
  description = "The error code associated with the assignment synchronization failure."
  type        = string
  default     = null
}

variable "message" {
  description = "The error message associated with the assignment synchronization failure."
  type        = string
  default     = null
}

variable "occurrence_date_time" {
  description = "The date and time at which the error most recently occurred. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudLicensing.assignmentError"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "skuId", "usageRight"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
