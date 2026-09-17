variable "call_record_id" {
  description = "The unique identifier of callRecord"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.call_record_id)) > 0
    error_message = "call_record_id must not be empty."
  }
}

variable "session_id" {
  description = "The unique identifier of session"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.session_id)) > 0
    error_message = "session_id must not be empty."
  }
}

variable "callee" {
  description = "Endpoint that answered this segment."
  type        = any
  default     = null
}

variable "caller" {
  description = "Endpoint that initiated this segment."
  type        = any
  default     = null
}

variable "end_date_time" {
  description = "UTC time when the segment ended. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "failure_info" {
  description = "Failure information associated with the segment if it failed."
  type        = any
  default     = null
}

variable "media" {
  description = "Media associated with this segment."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.callRecords.media")
    calleeDevice  = optional(any)
    calleeNetwork = optional(any)
    callerDevice  = optional(any)
    callerNetwork = optional(any)
    label         = optional(string)
    streams = optional(list(object({
      odata_type                               = optional(string, "#microsoft.graph.callRecords.mediaStream")
      audioCodec                               = optional(any)
      averageAudioDegradation                  = optional(any)
      averageAudioNetworkJitter                = optional(string)
      averageBandwidthEstimate                 = optional(number)
      averageFreezeDuration                    = optional(string)
      averageJitter                            = optional(string)
      averagePacketLossRate                    = optional(any)
      averageRatioOfConcealedSamples           = optional(any)
      averageReceivedFrameRate                 = optional(any)
      averageRoundTripTime                     = optional(string)
      averageVideoFrameLossPercentage          = optional(any)
      averageVideoFrameRate                    = optional(any)
      averageVideoPacketLossRate               = optional(any)
      endDateTime                              = optional(string)
      isAudioForwardErrorCorrectionUsed        = optional(bool)
      lowFrameRateRatio                        = optional(any)
      lowVideoProcessingCapabilityRatio        = optional(any)
      maxAudioNetworkJitter                    = optional(string)
      maxJitter                                = optional(string)
      maxPacketLossRate                        = optional(any)
      maxRatioOfConcealedSamples               = optional(any)
      maxRoundTripTime                         = optional(string)
      packetUtilization                        = optional(number)
      postForwardErrorCorrectionPacketLossRate = optional(any)
      rmsFreezeDuration                        = optional(string)
      startDateTime                            = optional(string)
      streamDirection                          = optional(string)
      streamId                                 = optional(string)
      videoCodec                               = optional(any)
      wasMediaBypassed                         = optional(bool)
    })))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.callRecords.segment"
  nullable    = false
}

variable "start_date_time" {
  description = "UTC time when the segment started. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
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
