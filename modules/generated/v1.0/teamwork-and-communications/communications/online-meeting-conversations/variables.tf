variable "creation_mode" {
  description = "Indicates that the resource is in migration state and is currently being used for migration purposes."
  type        = string
  default     = null

  validation {
    condition     = var.creation_mode == null ? true : contains(["none", "migration", "unknownFutureValue"], var.creation_mode)
    error_message = "creation_mode must be one of the documented enum values."
  }
}

variable "messages" {
  description = "The messages in a Viva Engage conversation."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.engagementConversationMessage")
    body = optional(object({
      odata_type  = optional(string, "#microsoft.graph.itemBody")
      content     = optional(string)
      contentType = optional(any)
    }))
    conversation = optional(object({
      odata_type   = optional(string, "#microsoft.graph.engagementConversation")
      creationMode = optional(string)
      messages     = optional(any)
      starter      = optional(any)
      starterId    = optional(string)
    }))
    creationMode = optional(string)
    from         = optional(any)
    reactions = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.engagementConversationMessageReaction")
      reactionBy = optional(object({
        odata_type  = optional(string, "#microsoft.graph.engagementIdentitySet")
        application = optional(any)
        audience    = optional(any)
        device      = optional(any)
        group       = optional(any)
        user        = optional(any)
      }))
      reactionType = optional(string)
    })))
    replies   = optional(any)
    replyTo   = optional(any)
    replyToId = optional(string)
  }))
  default = null
}

variable "moderation_state" {
  description = "Represents the moderation state of an Engage conversation message."
  type        = string
  default     = null

  validation {
    condition     = var.moderation_state == null ? true : contains(["published", "pendingReview", "dismissed", "unknownFutureValue"], var.moderation_state)
    error_message = "moderation_state must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.onlineMeetingEngagementConversation"
  nullable    = false
}

variable "online_meeting" {
  description = "Microsoft Graph onlineMeeting property."
  type = object({
    odata_type                           = optional(string, "#microsoft.graph.onlineMeeting")
    allowAttendeeToEnableCamera          = optional(bool)
    allowAttendeeToEnableMic             = optional(bool)
    allowBreakoutRooms                   = optional(bool)
    allowCopyingAndSharingMeetingContent = optional(bool)
    allowLiveShare                       = optional(any)
    allowMeetingChat                     = optional(any)
    allowParticipantsToChangeName        = optional(bool)
    allowPowerPointSharing               = optional(bool)
    allowRecording                       = optional(bool)
    allowTeamworkReactions               = optional(bool)
    allowTranscription                   = optional(bool)
    allowWhiteboard                      = optional(bool)
    allowedLobbyAdmitters                = optional(any)
    allowedPresenters                    = optional(any)
    broadcastSettings                    = optional(any)
    chatInfo                             = optional(any)
    chatRestrictions                     = optional(any)
    endDateTime                          = optional(string)
    expiryDateTime                       = optional(string)
    externalId                           = optional(string)
    isBroadcast                          = optional(bool)
    isEndToEndEncryptionEnabled          = optional(bool)
    isEntryExitAnnounced                 = optional(bool)
    joinMeetingIdSettings                = optional(any)
    lobbyBypassSettings                  = optional(any)
    meetingOptionsWebUrl                 = optional(string)
    meetingSpokenLanguageTag             = optional(string)
    meetingTemplateId                    = optional(string)
    participants                         = optional(any)
    recordAutomatically                  = optional(bool)
    sensitivityLabelAssignment           = optional(any)
    shareMeetingChatHistoryDefault       = optional(any)
    startDateTime                        = optional(string)
    subject                              = optional(string)
    watermarkProtection                  = optional(any)
  })
  default = null
}

variable "online_meeting_id" {
  description = "The unique identifier of the online meeting associated with this conversation. The online meeting ID links the conversation to a specific meeting instance."
  type        = string
  default     = null
}

variable "organizer" {
  description = "The Viva Engage identities."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.engagementIdentitySet")
    application = optional(any)
    audience    = optional(any)
    device      = optional(any)
    group       = optional(any)
    user        = optional(any)
  })
  default = null
}

variable "starter" {
  description = "A Viva Engage conversation message."
  type = object({
    odata_type = optional(string, "#microsoft.graph.engagementConversationMessage")
    body = optional(object({
      odata_type  = optional(string, "#microsoft.graph.itemBody")
      content     = optional(string)
      contentType = optional(any)
    }))
    conversation = optional(object({
      odata_type   = optional(string, "#microsoft.graph.engagementConversation")
      creationMode = optional(string)
      messages     = optional(any)
      starter      = optional(any)
      starterId    = optional(string)
    }))
    creationMode = optional(string)
    from         = optional(any)
    reactions = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.engagementConversationMessageReaction")
      reactionBy = optional(object({
        odata_type  = optional(string, "#microsoft.graph.engagementIdentitySet")
        application = optional(any)
        audience    = optional(any)
        device      = optional(any)
        group       = optional(any)
        user        = optional(any)
      }))
      reactionType = optional(string)
    })))
    replies   = optional(any)
    replyTo   = optional(any)
    replyToId = optional(string)
  })
  default = null
}

variable "starter_id" {
  description = "The unique ID of the first message in a Viva Engage conversation."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "upvoteCount"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
