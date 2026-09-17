variable "agreement_id" {
  description = "The unique identifier of agreement"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.agreement_id)) > 0
    error_message = "agreement_id must not be empty."
  }
}

variable "agreement_file_id" {
  description = "ID of the agreement file accepted by the user."
  type        = string
  default     = null
}

variable "agreement_id_2" {
  description = "ID of the agreement."
  type        = string
  default     = null
}

variable "device_display_name" {
  description = "The display name of the device used for accepting the agreement."
  type        = string
  default     = null
}

variable "device_id" {
  description = "The unique identifier of the device used for accepting the agreement. Supports $filter (eq) and eq for null values."
  type        = string
  default     = null
}

variable "device_os_type" {
  description = "The operating system used for accepting the agreement."
  type        = string
  default     = null
}

variable "device_os_version" {
  description = "The operating system version of the device used for accepting the agreement."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "The expiration date time of the acceptance. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Supports $filter (eq, ge, le) and eq for null values."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.agreementAcceptance"
  nullable    = false
}

variable "recorded_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Supports $filter (eq) and eq for null values."
  type        = string
  default     = null
}

variable "state" {
  description = "The possible values are: accepted, declined. Supports $filter (eq)."
  type        = any
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["accepted", "declined", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "user_display_name" {
  description = "Display name of the user when the acceptance was recorded."
  type        = string
  default     = null
}

variable "user_email" {
  description = "Email of the user when the acceptance was recorded."
  type        = string
  default     = null
}

variable "user_id" {
  description = "ID of the user who accepted the agreement. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "UPN of the user when the acceptance was recorded."
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
