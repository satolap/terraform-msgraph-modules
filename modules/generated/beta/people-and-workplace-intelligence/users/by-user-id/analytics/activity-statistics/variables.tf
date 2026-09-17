variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "activity" {
  description = "The type of activity for which statistics are returned. The possible values are: call, chat, email, focus, and meeting."
  type        = any
  default     = null

  validation {
    condition     = var.activity == null ? true : contains(["Email", "Meeting", "Focus", "Chat", "Call"], var.activity)
    error_message = "activity must be one of the documented enum values."
  }
}

variable "duration" {
  description = "Total hours spent on the activity. The value is represented in ISO 8601 format for durations."
  type        = string
  default     = null
}

variable "end_date" {
  description = "Date when the activity ended, expressed in ISO 8601 format for calendar dates. For example, the property value could be '2019-07-03' that follows the YYYY-MM-DD format."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.activityStatistics"
  nullable    = false
}

variable "start_date" {
  description = "Date when the activity started, expressed in ISO 8601 format for calendar dates. For example, the property value could be '2019-07-04' that follows the YYYY-MM-DD format."
  type        = string
  default     = null
}

variable "time_zone_used" {
  description = "The time zone that the user sets in Microsoft Outlook is used for the computation. For example, the property value could be 'Pacific Standard Time.'"
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
