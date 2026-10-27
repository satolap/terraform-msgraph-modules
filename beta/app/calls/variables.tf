variable "audio_routing_groups" {
  description = "Microsoft Graph audioRoutingGroups property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.audioRoutingGroup")
    receivers   = optional(list(string))
    routingMode = optional(string)
    sources     = optional(list(string))
  }))
  default = null

  validation {
    condition     = (var.audio_routing_groups == null ? true : alltrue([alltrue([for input0 in var.audio_routing_groups : (input0 == null ? true : alltrue([(input0["routingMode"] == null ? true : alltrue([(input0["routingMode"] == null ? true : contains(["oneToOne", "multicast"], input0["routingMode"]))]))]))])]))
    error_message = "audio_routing_groups: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "call_chain_id" {
  description = "A unique identifier for all the participant calls in a conference or a unique identifier for two participant calls in a P2P call.  This needs to be copied over from Microsoft.Graph.Call.CallChainId."
  type        = string
  default     = null
}

variable "call_options" {
  description = "Contains the optional features for the call."
  type        = any
  default     = null
}

variable "callback_uri" {
  description = "The callback URL on which callbacks will be delivered. Must be https."
  type        = string
  default     = null
}

variable "chat_info" {
  description = "The chat information. Required information for meeting scenarios."
  type = object({
    odata_type          = optional(string, "#microsoft.graph.chatInfo")
    messageId           = optional(string)
    replyChainMessageId = optional(string)
    threadId            = optional(string)
  })
  default = null
}

variable "content_sharing_sessions" {
  description = "Microsoft Graph contentSharingSessions property."
  type = list(object({
    odata_type             = optional(string, "#microsoft.graph.contentSharingSession")
    pngOfCurrentSlide      = optional(string)
    presenterParticipantId = optional(string)
  }))
  default = null
}

variable "graph_source" {
  description = "The originator of the call."
  type = object({
    odata_type            = optional(string, "#microsoft.graph.participantInfo")
    identity              = optional(any)
    nonAnonymizedIdentity = optional(any)
  })
  default = null
}

variable "media_config" {
  description = "The media configuration. Required information for creating peer to peer calls or joining meetings."
  type        = any
  default     = null
}

variable "meeting_info" {
  description = "The meeting information. Required information for meeting scenarios."
  type        = any
  default     = null
}

variable "my_participant_id" {
  description = "Microsoft Graph myParticipantId property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.call"
  nullable    = false
}

variable "operations" {
  description = "Microsoft Graph operations property."
  type        = any
  default     = null
}

variable "participants" {
  description = "Microsoft Graph participants property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.participant")
    info = optional(object({
      odata_type            = optional(string, "#microsoft.graph.participantInfo")
      identity              = optional(any)
      nonAnonymizedIdentity = optional(any)
    }))
    isIdentityAnonymized = optional(bool)
    isInLobby            = optional(bool)
    isMuted              = optional(bool)
    mediaStreams = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.mediaStream")
      direction   = optional(string)
      label       = optional(string)
      mediaType   = optional(string)
      serverMuted = optional(bool)
      sourceId    = optional(string)
    })))
    metadata             = optional(string)
    preferredDisplayName = optional(string)
    recordingInfo = optional(object({
      odata_type = optional(string, "#microsoft.graph.recordingInfo")
      initiatedBy = optional(object({
        odata_type            = optional(string, "#microsoft.graph.participantInfo")
        identity              = optional(any)
        nonAnonymizedIdentity = optional(any)
      }))
      initiator       = optional(any)
      recordingStatus = optional(string)
    }))
    removedState = optional(object({
      odata_type = optional(string, "#microsoft.graph.removedState")
      reason     = optional(string)
    }))
    restrictedExperience = optional(object({
      odata_type             = optional(string, "#microsoft.graph.onlineMeetingRestricted")
      contentSharingDisabled = optional(string)
      videoDisabled          = optional(string)
    }))
    rosterSequenceNumber = optional(number)
    syntheticMediaDetection = optional(object({
      odata_type           = optional(string, "#microsoft.graph.syntheticMediaDetectionInfo")
      detectionId          = optional(string)
      detectorBot          = optional(string)
      isParticipantTrusted = optional(bool)
      syntheticConfidence  = optional(any)
    }))
  }))
  default = null

  validation {
    condition     = (var.participants == null ? true : alltrue([alltrue([for input0 in var.participants : (input0 == null ? true : alltrue([(input0["mediaStreams"] == null ? true : alltrue([alltrue([for input2 in input0["mediaStreams"] : (input2 == null ? true : alltrue([(input2["direction"] == null ? true : alltrue([(input2["direction"] == null ? true : contains(["inactive", "sendOnly", "receiveOnly", "sendReceive"], input2["direction"]))])), (input2["mediaType"] == null ? true : alltrue([(input2["mediaType"] == null ? true : contains(["unknown", "audio", "video", "videoBasedScreenSharing", "data"], input2["mediaType"]))]))]))])])), (input0["recordingInfo"] == null ? true : alltrue([(input0["recordingInfo"]["recordingStatus"] == null ? true : alltrue([(input0["recordingInfo"]["recordingStatus"] == null ? true : contains(["unknown", "notRecording", "recording", "failed"], input0["recordingInfo"]["recordingStatus"]))]))])), (input0["restrictedExperience"] == null ? true : alltrue([(input0["restrictedExperience"]["contentSharingDisabled"] == null ? true : alltrue([(input0["restrictedExperience"]["contentSharingDisabled"] == null ? true : try(alltrue([for value in split(",", input0["restrictedExperience"]["contentSharingDisabled"]) : contains(["watermarkprotection"], lower(trimspace(value)))]), false))])), (input0["restrictedExperience"]["videoDisabled"] == null ? true : alltrue([(input0["restrictedExperience"]["videoDisabled"] == null ? true : try(alltrue([for value in split(",", input0["restrictedExperience"]["videoDisabled"]) : contains(["watermarkprotection"], lower(trimspace(value)))]), false))]))]))]))])]))
    error_message = "participants: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "requested_modalities" {
  description = "The list of requested modalities. The possible values are: unknown, audio, video, videoBasedScreenSharing, data."
  type        = list(string)
  default     = null

  validation {
    condition     = (var.requested_modalities == null ? true : alltrue([alltrue([for input0 in var.requested_modalities : (input0 == null ? true : alltrue([(input0 == null ? true : contains(["unknown", "audio", "video", "videoBasedScreenSharing", "data"], input0))]))])]))
    error_message = "requested_modalities: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "ringing_timeout_in_seconds" {
  description = "Ringing timeout in seconds for outgoing peer to peer calls. The max value for this attribute is 115 seconds."
  type        = number
  default     = null
}

variable "routing_policies" {
  description = "This property is applicable for peer to peer calls only. The possible values are: none, noMissedCall, disableForwardingExceptPhone, disableForwarding, preferSkypeForBusiness, unknownFutureValue."
  type        = list(string)
  default     = null

  validation {
    condition     = (var.routing_policies == null ? true : alltrue([alltrue([for input0 in var.routing_policies : (input0 == null ? true : alltrue([(input0 == null ? true : contains(["none", "noMissedCall", "disableForwardingExceptPhone", "disableForwarding", "preferSkypeForBusiness"], input0))]))])]))
    error_message = "routing_policies: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "subject" {
  description = "The subject of the conversation."
  type        = string
  default     = null
}

variable "targets" {
  description = "The targets of the call. Required information for creating peer to peer call."
  type = list(object({
    odata_type                         = optional(string, "#microsoft.graph.invitationParticipantInfo")
    endpointType                       = optional(string)
    hidden                             = optional(bool)
    identity                           = optional(any)
    participantId                      = optional(string)
    removeFromDefaultAudioRoutingGroup = optional(bool)
    replacesCallId                     = optional(string)
  }))
  default = null

  validation {
    condition     = (var.targets == null ? true : alltrue([alltrue([for input0 in var.targets : (input0 == null ? true : alltrue([(input0["endpointType"] == null ? true : alltrue([(input0["endpointType"] == null ? true : contains(["default", "voicemail", "skypeForBusiness", "skypeForBusinessVoipPhone"], input0["endpointType"]))]))]))])]))
    error_message = "targets: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "termination_reason" {
  description = "Microsoft Graph terminationReason property."
  type        = string
  default     = null
}

variable "tone_info" {
  description = "Microsoft Graph toneInfo property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.toneInfo")
    sequenceId = optional(number)
    tone       = optional(string)
  })
  default = null

  validation {
    condition     = (var.tone_info == null ? true : alltrue([(var.tone_info["tone"] == null ? true : alltrue([(var.tone_info["tone"] == null ? true : contains(["tone0", "tone1", "tone2", "tone3", "tone4", "tone5", "tone6", "tone7", "tone8", "tone9", "star", "pound", "a", "b", "c", "d", "flash"], var.tone_info["tone"]))]))]))
    error_message = "tone_info: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["activeModalities", "answeredBy", "callRoutes", "direction", "id", "incomingContext", "mediaState", "meetingCapability", "resultInfo", "state", "tenantId", "transcription"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
