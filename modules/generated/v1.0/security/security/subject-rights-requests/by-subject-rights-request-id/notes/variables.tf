variable "subject_rights_request_id" {
  description = "The unique identifier of subjectRightsRequest"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.subject_rights_request_id)) > 0
    error_message = "subject_rights_request_id must not be empty."
  }
}

variable "author" {
  description = "Identity information about the note's author."
  type        = any
  default     = null
}

variable "content" {
  description = "The content of the note."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the entity was created. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.authoredNote"
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
