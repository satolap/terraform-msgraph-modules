variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "calendar_group_id" {
  description = "The unique identifier of calendarGroup"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.calendar_group_id)) > 0
    error_message = "calendar_group_id must not be empty."
  }
}

variable "calendar_id" {
  description = "The unique identifier of calendar"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.calendar_id)) > 0
    error_message = "calendar_id must not be empty."
  }
}

variable "event_id" {
  description = "The unique identifier of event"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.event_id)) > 0
    error_message = "event_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.extension"
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
