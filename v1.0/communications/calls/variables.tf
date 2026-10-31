variable "audioRoutingGroups" {
  description = "Microsoft Graph audioRoutingGroups property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.audioRoutingGroup")
    receivers   = optional(list(string))
    routingMode = optional(string)
    sources     = optional(list(string))
  }))
  default = null

  validation {
    condition     = (var.audioRoutingGroups == null ? true : alltrue([alltrue([for input0 in var.audioRoutingGroups : (input0 == null ? true : alltrue([(input0["routingMode"] == null ? true : alltrue([(input0["routingMode"] == null ? true : contains(["oneToOne", "multicast"], input0["routingMode"]))]))]))])]))
    error_message = "audioRoutingGroups: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "callChainId" {
  description = "A unique identifier for all the participant calls in a conference or a unique identifier for two participant calls in a P2P call.  This identifier must be copied over from Microsoft.Graph.Call.CallChainId."
  type        = string
  default     = null
}

variable "callOptions" {
  description = "Contains the optional features for the call."
  type        = any
  default     = null
}

variable "callbackUri" {
  description = "The callback URL on which callbacks are delivered. Must be an HTTPS URL."
  type        = string
  default     = null
}

variable "chatInfo" {
  description = "The chat information. Required information for joining a meeting."
  type = object({
    odata_type          = optional(string, "#microsoft.graph.chatInfo")
    messageId           = optional(string)
    replyChainMessageId = optional(string)
    threadId            = optional(string)
  })
  default = null
}

variable "contentSharingSessions" {
  description = "Microsoft Graph contentSharingSessions property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.contentSharingSession")
  }))
  default = null
}

variable "graph_source" {
  description = "The originator of the call."
  type = object({
    odata_type = optional(string, "#microsoft.graph.participantInfo")
    identity   = optional(any)
  })
  default = null
}

variable "incomingContext" {
  description = "Call context associated with an incoming call."
  type = object({
    odata_type = optional(string, "#microsoft.graph.incomingContext")
    onBehalfOf = optional(any)
    transferor = optional(any)
  })
  default = null
}

variable "mediaConfig" {
  description = "The media configuration. Required."
  type        = any
  default     = null
}

variable "meetingInfo" {
  description = "The meeting information. Required information for meeting scenarios."
  type        = any
  default     = null
}

variable "myParticipantId" {
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
      odata_type = optional(string, "#microsoft.graph.participantInfo")
      identity   = optional(any)
    }))
    isInLobby = optional(bool)
    isMuted   = optional(bool)
    mediaStreams = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.mediaStream")
      direction   = optional(string)
      label       = optional(string)
      mediaType   = optional(string)
      serverMuted = optional(bool)
      sourceId    = optional(string)
    })))
    metadata = optional(string)
    recordingInfo = optional(object({
      odata_type      = optional(string, "#microsoft.graph.recordingInfo")
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
  }))
  default = null

  validation {
    condition     = (var.participants == null ? true : alltrue([alltrue([for input0 in var.participants : (input0 == null ? true : alltrue([(input0["mediaStreams"] == null ? true : alltrue([alltrue([for input2 in input0["mediaStreams"] : (input2 == null ? true : alltrue([(input2["direction"] == null ? true : alltrue([(input2["direction"] == null ? true : contains(["inactive", "sendOnly", "receiveOnly", "sendReceive"], input2["direction"]))])), (input2["mediaType"] == null ? true : alltrue([(input2["mediaType"] == null ? true : contains(["audio", "video", "videoBasedScreenSharing", "data"], input2["mediaType"]))]))]))])])), (input0["recordingInfo"] == null ? true : alltrue([(input0["recordingInfo"]["recordingStatus"] == null ? true : alltrue([(input0["recordingInfo"]["recordingStatus"] == null ? true : contains(["unknown", "notRecording", "recording", "failed"], input0["recordingInfo"]["recordingStatus"]))]))])), (input0["restrictedExperience"] == null ? true : alltrue([(input0["restrictedExperience"]["contentSharingDisabled"] == null ? true : alltrue([(input0["restrictedExperience"]["contentSharingDisabled"] == null ? true : try(alltrue([for value in split(",", input0["restrictedExperience"]["contentSharingDisabled"]) : contains(["watermarkprotection"], lower(trimspace(value)))]), false))])), (input0["restrictedExperience"]["videoDisabled"] == null ? true : alltrue([(input0["restrictedExperience"]["videoDisabled"] == null ? true : try(alltrue([for value in split(",", input0["restrictedExperience"]["videoDisabled"]) : contains(["watermarkprotection"], lower(trimspace(value)))]), false))]))]))]))])]))
    error_message = "participants: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "requestedModalities" {
  description = "The list of requested modalities. The possible values are: unknown, audio, video, videoBasedScreenSharing, data."
  type        = list(string)
  default     = null

  validation {
    condition     = (var.requestedModalities == null ? true : alltrue([alltrue([for input0 in var.requestedModalities : (input0 == null ? true : alltrue([(input0 == null ? true : contains(["audio", "video", "videoBasedScreenSharing", "data"], input0))]))])]))
    error_message = "requestedModalities: nested required attributes must be non-null and enum values must be supported input members."
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
    hidden                             = optional(bool)
    identity                           = optional(any)
    participantId                      = optional(string)
    removeFromDefaultAudioRoutingGroup = optional(bool)
    replacesCallId                     = optional(string)
  }))
  default = null
}

variable "tenantId" {
  description = "Microsoft Graph tenantId property."
  type        = string
  default     = null
}

variable "toneInfo" {
  description = "Microsoft Graph toneInfo property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.toneInfo")
    sequenceId = optional(number)
    tone       = optional(string)
  })
  default = null

  validation {
    condition     = (var.toneInfo == null ? true : alltrue([(var.toneInfo["tone"] == null ? true : alltrue([(var.toneInfo["tone"] == null ? true : contains(["tone0", "tone1", "tone2", "tone3", "tone4", "tone5", "tone6", "tone7", "tone8", "tone9", "star", "pound", "a", "b", "c", "d", "flash"], var.toneInfo["tone"]))]))]))
    error_message = "toneInfo: nested required attributes must be non-null and enum values must be supported input members."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["callRoutes", "direction", "id", "mediaState", "resultInfo", "state", "transcription"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
