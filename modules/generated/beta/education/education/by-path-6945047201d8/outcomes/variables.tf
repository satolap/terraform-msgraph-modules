variable "education_class_id" {
  description = "The unique identifier of educationClass"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.education_class_id)) > 0
    error_message = "education_class_id must not be empty."
  }
}

variable "education_assignment_id" {
  description = "The unique identifier of educationAssignment"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.education_assignment_id)) > 0
    error_message = "education_assignment_id must not be empty."
  }
}

variable "education_submission_id" {
  description = "The unique identifier of educationSubmission"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.education_submission_id)) > 0
    error_message = "education_submission_id must not be empty."
  }
}

variable "last_modified_by" {
  description = "The individual who updated the resource."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The moment in time when the resource was last modified. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2021 is 2021-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.educationOutcome"
  nullable    = false
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
