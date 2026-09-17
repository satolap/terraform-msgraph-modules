variable "audio_routing_groups" {
  description = "Microsoft Graph audioRoutingGroups property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.audioRoutingGroup")
    receivers   = optional(list(string))
    routingMode = optional(string)
    sources     = optional(list(string))
  }))
  default = null
}

variable "call_chain_id" {
  description = "A unique identifier for all the participant calls in a conference or a unique identifier for two participant calls in a P2P call.  This identifier must be copied over from Microsoft.Graph.Call.CallChainId."
  type        = string
  default     = null
}

variable "call_options" {
  description = "Contains the optional features for the call."
  type        = any
  default     = null
}

variable "callback_uri" {
  description = "The callback URL on which callbacks are delivered. Must be an HTTPS URL."
  type        = string
  default     = null
}

variable "chat_info" {
  description = "The chat information. Required information for joining a meeting."
  type        = any
  default     = null
}

variable "content_sharing_sessions" {
  description = "Microsoft Graph contentSharingSessions property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.contentSharingSession")
  }))
  default = null
}

variable "graph_source" {
  description = "The originator of the call."
  type        = any
  default     = null
}

variable "incoming_context" {
  description = "Call context associated with an incoming call."
  type        = any
  default     = null
}

variable "media_config" {
  description = "The media configuration. Required."
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
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.commsOperation")
    clientContext = optional(string)
    status        = optional(string)
  }))
  default = null
}

variable "participants" {
  description = "Microsoft Graph participants property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.participant")
    info = optional(object({
      odata_type = optional(string, "#microsoft.graph.participantInfo")
      identity = optional(object({
        odata_type  = optional(string, "#microsoft.graph.identitySet")
        application = optional(any)
        device      = optional(any)
        user        = optional(any)
      }))
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
    metadata             = optional(string)
    recordingInfo        = optional(any)
    removedState         = optional(any)
    restrictedExperience = optional(any)
    rosterSequenceNumber = optional(number)
  }))
  default = null
}

variable "requested_modalities" {
  description = "The list of requested modalities. The possible values are: unknown, audio, video, videoBasedScreenSharing, data."
  type        = any
  default     = null
}

variable "subject" {
  description = "The subject of the conversation."
  type        = string
  default     = null
}

variable "targets" {
  description = "The targets of the call. Required information for creating peer to peer call."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.invitationParticipantInfo")
    hidden     = optional(bool)
    identity = optional(object({
      odata_type  = optional(string, "#microsoft.graph.identitySet")
      application = optional(any)
      device      = optional(any)
      user        = optional(any)
    }))
    participantId                      = optional(string)
    removeFromDefaultAudioRoutingGroup = optional(bool)
    replacesCallId                     = optional(string)
  }))
  default = null
}

variable "tenant_id" {
  description = "Microsoft Graph tenantId property."
  type        = string
  default     = null
}

variable "tone_info" {
  description = "Microsoft Graph toneInfo property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["callRoutes", "direction", "id", "mediaState", "resultInfo", "state", "transcription"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
