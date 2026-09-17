variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.realtimeActivityMeeting"
  nullable    = false
}

variable "transcripts" {
  description = "Microsoft Graph transcripts property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.realTimeTranscript")
    payloads = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.transcriptPayload")
      audioCaptureDateTime = optional(string)
      speaker              = optional(any)
      spokenLanguage       = optional(string)
      text                 = optional(string)
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
