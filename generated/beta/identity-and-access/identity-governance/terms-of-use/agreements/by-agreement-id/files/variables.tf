variable "agreement_id" {
  description = "The unique identifier of agreement"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.agreement_id)) > 0
    error_message = "agreement_id must not be empty."
  }
}

variable "created_date_time" {
  description = "The date time representing when the file was created. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Localized display name of the policy file of an agreement. The localized display name is shown to end users who view the agreement."
  type        = string
  default     = null
}

variable "is_major_version" {
  description = "Indicates whether the agreement file is a major version update. Major version updates invalidate the agreement's acceptances on the corresponding language."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.agreementFileLocalization"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["fileData", "fileName", "id", "isDefault", "language", "versions"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
