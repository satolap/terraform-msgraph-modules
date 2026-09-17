variable "site_id" {
  description = "The unique identifier of site"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.site_id)) > 0
    error_message = "site_id must not be empty."
  }
}

variable "category" {
  description = "Microsoft Graph category property."
  type        = string
  default     = null

  validation {
    condition     = var.category == null ? true : contains(["undefined", "spam", "phishing", "malware", "unknownFutureValue"], var.category)
    error_message = "category must be one of the documented enum values."
  }
}

variable "content_type" {
  description = "The content type of threat assessment. The possible values are: mail, url, file."
  type        = any
  default     = null

  validation {
    condition     = var.content_type == null ? true : contains(["mail", "url", "file"], var.content_type)
    error_message = "content_type must be one of the documented enum values."
  }
}

variable "created_by" {
  description = "The threat assessment request creator."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "expected_assessment" {
  description = "Microsoft Graph expectedAssessment property."
  type        = string
  default     = null

  validation {
    condition     = var.expected_assessment == null ? true : contains(["block", "unblock"], var.expected_assessment)
    error_message = "expected_assessment must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.threatAssessmentRequest"
  nullable    = false
}

variable "request_source" {
  description = "The source of the threat assessment request. The possible values are: user, administrator."
  type        = any
  default     = null

  validation {
    condition     = var.request_source == null ? true : contains(["undefined", "user", "administrator"], var.request_source)
    error_message = "request_source must be one of the documented enum values."
  }
}

variable "status" {
  description = "The assessment process status. The possible values are: pending, completed."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["pending", "completed"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "results"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
