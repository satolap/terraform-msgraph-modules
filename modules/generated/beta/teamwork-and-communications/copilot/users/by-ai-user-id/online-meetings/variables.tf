variable "ai_user_id" {
  description = "The unique identifier of aiUser"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ai_user_id)) > 0
    error_message = "ai_user_id must not be empty."
  }
}

variable "ai_insights" {
  description = "Microsoft Graph aiInsights property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.callAiInsight")
    actionItems = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.actionItem")
      ownerDisplayName = optional(string)
      text             = optional(string)
      title            = optional(string)
    })))
    callId               = optional(string)
    contentCorrelationId = optional(string)
    createdDateTime      = optional(string)
    endDateTime          = optional(string)
    meetingNotes = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.meetingNote")
      subpoints  = optional(any)
      text       = optional(string)
      title      = optional(string)
    })))
    viewpoint = optional(any)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.aiOnlineMeeting"
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
