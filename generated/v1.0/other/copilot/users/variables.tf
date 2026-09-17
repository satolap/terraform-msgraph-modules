variable "interaction_history" {
  description = "Microsoft Graph interactionHistory property."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.aiUser"
  nullable    = false
}

variable "online_meetings" {
  description = "Microsoft Graph onlineMeetings property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.aiOnlineMeeting")
    aiInsights = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.callAiInsight")
      actionItems          = optional(any)
      callId               = optional(string)
      contentCorrelationId = optional(string)
      createdDateTime      = optional(string)
      endDateTime          = optional(string)
      meetingNotes         = optional(any)
      viewpoint            = optional(any)
    })))
  }))
  default = null
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
