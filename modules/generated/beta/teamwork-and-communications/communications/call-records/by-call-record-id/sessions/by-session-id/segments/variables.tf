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
  type = object({
    odata_type = optional(string, "#microsoft.graph.callRecords.failureInfo")
    reason     = optional(string)
    stage      = optional(string)
  })
  default = null
}

variable "media" {
  description = "Media associated with this segment."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.callRecords.media")
    calleeDevice = optional(object({
      odata_type                       = optional(string, "#microsoft.graph.callRecords.deviceInfo")
      captureDeviceDriver              = optional(string)
      captureDeviceName                = optional(string)
      captureNotFunctioningEventRatio  = optional(any)
      cpuInsufficentEventRatio         = optional(any)
      deviceClippingEventRatio         = optional(any)
      deviceGlitchEventRatio           = optional(any)
      howlingEventCount                = optional(number)
      initialSignalLevelRootMeanSquare = optional(any)
      lowSpeechLevelEventRatio         = optional(any)
      lowSpeechToNoiseEventRatio       = optional(any)
      micGlitchRate                    = optional(any)
      receivedNoiseLevel               = optional(number)
      receivedSignalLevel              = optional(number)
      renderDeviceDriver               = optional(string)
      renderDeviceName                 = optional(string)
      renderMuteEventRatio             = optional(any)
      renderNotFunctioningEventRatio   = optional(any)
      renderZeroVolumeEventRatio       = optional(any)
      sentNoiseLevel                   = optional(number)
      sentSignalLevel                  = optional(number)
      speakerGlitchRate                = optional(any)
    }))
    calleeNetwork = optional(object({
      odata_type                = optional(string, "#microsoft.graph.callRecords.networkInfo")
      bandwidthLowEventRatio    = optional(any)
      basicServiceSetIdentifier = optional(string)
      connectionType            = optional(string)
      delayEventRatio           = optional(any)
      dnsSuffix                 = optional(string)
      ipAddress                 = optional(string)
      linkSpeed                 = optional(number)
      macAddress                = optional(string)
      networkTransportProtocol  = optional(string)
      port                      = optional(number)
      receivedQualityEventRatio = optional(any)
      reflexiveIPAddress        = optional(string)
      relayIPAddress            = optional(string)
      relayPort                 = optional(number)
      sentQualityEventRatio     = optional(any)
      subnet                    = optional(string)
      traceRouteHops = optional(list(object({
        odata_type    = optional(string, "#microsoft.graph.callRecords.traceRouteHop")
        hopCount      = optional(number)
        ipAddress     = optional(string)
        roundTripTime = optional(string)
      })))
      wifiBand                   = optional(string)
      wifiBatteryCharge          = optional(number)
      wifiChannel                = optional(number)
      wifiMicrosoftDriver        = optional(string)
      wifiMicrosoftDriverVersion = optional(string)
      wifiRadioType              = optional(string)
      wifiSignalStrength         = optional(number)
      wifiVendorDriver           = optional(string)
      wifiVendorDriverVersion    = optional(string)
    }))
    callerDevice = optional(object({
      odata_type                       = optional(string, "#microsoft.graph.callRecords.deviceInfo")
      captureDeviceDriver              = optional(string)
      captureDeviceName                = optional(string)
      captureNotFunctioningEventRatio  = optional(any)
      cpuInsufficentEventRatio         = optional(any)
      deviceClippingEventRatio         = optional(any)
      deviceGlitchEventRatio           = optional(any)
      howlingEventCount                = optional(number)
      initialSignalLevelRootMeanSquare = optional(any)
      lowSpeechLevelEventRatio         = optional(any)
      lowSpeechToNoiseEventRatio       = optional(any)
      micGlitchRate                    = optional(any)
      receivedNoiseLevel               = optional(number)
      receivedSignalLevel              = optional(number)
      renderDeviceDriver               = optional(string)
      renderDeviceName                 = optional(string)
      renderMuteEventRatio             = optional(any)
      renderNotFunctioningEventRatio   = optional(any)
      renderZeroVolumeEventRatio       = optional(any)
      sentNoiseLevel                   = optional(number)
      sentSignalLevel                  = optional(number)
      speakerGlitchRate                = optional(any)
    }))
    callerNetwork = optional(object({
      odata_type                = optional(string, "#microsoft.graph.callRecords.networkInfo")
      bandwidthLowEventRatio    = optional(any)
      basicServiceSetIdentifier = optional(string)
      connectionType            = optional(string)
      delayEventRatio           = optional(any)
      dnsSuffix                 = optional(string)
      ipAddress                 = optional(string)
      linkSpeed                 = optional(number)
      macAddress                = optional(string)
      networkTransportProtocol  = optional(string)
      port                      = optional(number)
      receivedQualityEventRatio = optional(any)
      reflexiveIPAddress        = optional(string)
      relayIPAddress            = optional(string)
      relayPort                 = optional(number)
      sentQualityEventRatio     = optional(any)
      subnet                    = optional(string)
      traceRouteHops = optional(list(object({
        odata_type    = optional(string, "#microsoft.graph.callRecords.traceRouteHop")
        hopCount      = optional(number)
        ipAddress     = optional(string)
        roundTripTime = optional(string)
      })))
      wifiBand                   = optional(string)
      wifiBatteryCharge          = optional(number)
      wifiChannel                = optional(number)
      wifiMicrosoftDriver        = optional(string)
      wifiMicrosoftDriverVersion = optional(string)
      wifiRadioType              = optional(string)
      wifiSignalStrength         = optional(number)
      wifiVendorDriver           = optional(string)
      wifiVendorDriverVersion    = optional(string)
    }))
    label = optional(string)
    streams = optional(list(object({
      odata_type                               = optional(string, "#microsoft.graph.callRecords.mediaStream")
      audioCodec                               = optional(string)
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
      videoCodec                               = optional(string)
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
