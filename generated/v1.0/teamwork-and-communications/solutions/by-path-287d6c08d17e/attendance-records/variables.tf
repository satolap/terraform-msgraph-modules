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

variable "meeting_attendance_report_id" {
  description = "The unique identifier of meetingAttendanceReport"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.meeting_attendance_report_id)) > 0
    error_message = "meeting_attendance_report_id must not be empty."
  }
}

variable "attendance_intervals" {
  description = "List of time periods between joining and leaving a meeting."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.attendanceInterval")
    durationInSeconds = optional(number)
    joinDateTime      = optional(string)
    leaveDateTime     = optional(string)
  }))
  default = null
}

variable "email_address" {
  description = "Email address of the user associated with this attendance record."
  type        = string
  default     = null
}

variable "external_registration_information" {
  description = "The external information for a virtualEventRegistration."
  type        = any
  default     = null
}

variable "identity" {
  description = "The identity of the user associated with this attendance record. The specific type is one of the following derived types of identity, depending on the user type: communicationsUserIdentity, azureCommunicationServicesUserIdentity."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.attendanceRecord"
  nullable    = false
}

variable "registration_id" {
  description = "Unique identifier of a virtualEventRegistration that is available to all participants registered for the virtualEventWebinar."
  type        = string
  default     = null
}

variable "role" {
  description = "Role of the attendee. The possible values are: None, Attendee, Presenter, and Organizer."
  type        = string
  default     = null
}

variable "total_attendance_in_seconds" {
  description = "Total duration of the attendances in seconds."
  type        = number
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
