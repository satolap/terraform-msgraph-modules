variable "virtual_event_webinar_id" {
  description = "The unique identifier of virtualEventWebinar"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.virtual_event_webinar_id)) > 0
    error_message = "virtual_event_webinar_id must not be empty."
  }
}

variable "virtual_event_session_id" {
  description = "The unique identifier of virtualEventSession"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.virtual_event_session_id)) > 0
    error_message = "virtual_event_session_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.meetingAttendanceReport"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["attendanceRecords", "externalEventInformation", "id", "meetingEndDateTime", "meetingStartDateTime", "totalParticipantCount"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
