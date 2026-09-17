variable "call_record_id" {
  description = "The unique identifier of callRecord"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.call_record_id)) > 0
    error_message = "call_record_id must not be empty."
  }
}

variable "callee" {
  description = "Endpoint that answered the session."
  type        = any
  default     = null
}

variable "caller" {
  description = "Endpoint that initiated the session."
  type        = any
  default     = null
}

variable "end_date_time" {
  description = "UTC time when the last user left the session. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "failure_info" {
  description = "Failure information associated with the session if the session failed."
  type        = any
  default     = null
}

variable "is_test" {
  description = "Specifies whether the session is a test."
  type        = bool
  default     = null
}

variable "modalities" {
  description = "List of modalities present in the session. The possible values are: unknown, audio, video, videoBasedScreenSharing, data, screenSharing, unknownFutureValue."
  type        = list(string)
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.callRecords.session"
  nullable    = false
}

variable "start_date_time" {
  description = "UTC time when the first user joined the session. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "segments"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
