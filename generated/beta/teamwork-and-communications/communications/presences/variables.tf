variable "activity" {
  description = "The supplemental information to a user's availability. Possible values are available, away, beRightBack, busy, doNotDisturb, offline, outOfOffice, presenceUnknown."
  type        = string
  default     = null
}

variable "availability" {
  description = "The base presence information for a user. Possible values are available, away, beRightBack, busy, doNotDisturb, focusing, inACall, inAMeeting, offline, presenting, presenceUnknown."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.presence"
  nullable    = false
}

variable "out_of_office_settings" {
  description = "The out of office settings for a user."
  type        = any
  default     = null
}

variable "status_message" {
  description = "The presence status message of a user."
  type        = any
  default     = null
}

variable "work_location" {
  description = "Represents the user’s aggregated work location state."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "sequenceNumber"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
