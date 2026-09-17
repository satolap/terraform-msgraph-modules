variable "threat_assessment_request_id" {
  description = "The unique identifier of threatAssessmentRequest"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.threat_assessment_request_id)) > 0
    error_message = "threat_assessment_request_id must not be empty."
  }
}

variable "created_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "message" {
  description = "The result message for each threat assessment."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.threatAssessmentResult"
  nullable    = false
}

variable "result_type" {
  description = "The threat assessment result type. The possible values are: checkPolicy (only for mail assessment), rescan."
  type        = any
  default     = null

  validation {
    condition     = var.result_type == null ? true : contains(["checkPolicy", "rescan", "unknownFutureValue"], var.result_type)
    error_message = "result_type must be one of the documented enum values."
  }
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
