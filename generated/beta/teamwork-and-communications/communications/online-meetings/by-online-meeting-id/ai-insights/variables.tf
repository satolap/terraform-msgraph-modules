variable "online_meeting_id" {
  description = "The unique identifier of onlineMeeting"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.online_meeting_id)) > 0
    error_message = "online_meeting_id must not be empty."
  }
}

variable "action_items" {
  description = "Microsoft Graph actionItems property."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.actionItem")
    ownerDisplayName = optional(string)
    text             = optional(string)
    title            = optional(string)
  }))
  default = null
}

variable "call_id" {
  description = "Microsoft Graph callId property."
  type        = string
  default     = null
}

variable "content_correlation_id" {
  description = "Microsoft Graph contentCorrelationId property."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "end_date_time" {
  description = "Microsoft Graph endDateTime property."
  type        = string
  default     = null
}

variable "meeting_notes" {
  description = "Microsoft Graph meetingNotes property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.meetingNote")
    subpoints = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.meetingNoteSubpoint")
      text       = optional(string)
      title      = optional(string)
    })))
    text  = optional(string)
    title = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.callAiInsight"
  nullable    = false
}

variable "viewpoint" {
  description = "Microsoft Graph viewpoint property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
