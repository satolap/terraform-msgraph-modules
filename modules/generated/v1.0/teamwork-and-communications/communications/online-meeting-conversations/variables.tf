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
  type        = any
  default     = null
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
    allowLiveShare                       = optional(string)
    allowMeetingChat                     = optional(string)
    allowParticipantsToChangeName        = optional(bool)
    allowPowerPointSharing               = optional(bool)
    allowRecording                       = optional(bool)
    allowTeamworkReactions               = optional(bool)
    allowTranscription                   = optional(bool)
    allowWhiteboard                      = optional(bool)
    allowedLobbyAdmitters                = optional(string)
    allowedPresenters                    = optional(string)
    broadcastSettings = optional(object({
      odata_type      = optional(string, "#microsoft.graph.broadcastMeetingSettings")
      allowedAudience = optional(string)
      captions = optional(object({
        odata_type           = optional(string, "#microsoft.graph.broadcastMeetingCaptionSettings")
        isCaptionEnabled     = optional(bool)
        spokenLanguage       = optional(string)
        translationLanguages = optional(list(string))
      }))
      isAttendeeReportEnabled    = optional(bool)
      isQuestionAndAnswerEnabled = optional(bool)
      isRecordingEnabled         = optional(bool)
      isVideoOnDemandEnabled     = optional(bool)
    }))
    chatInfo = optional(object({
      odata_type          = optional(string, "#microsoft.graph.chatInfo")
      messageId           = optional(string)
      replyChainMessageId = optional(string)
      threadId            = optional(string)
    }))
    chatRestrictions = optional(object({
      odata_type    = optional(string, "#microsoft.graph.chatRestrictions")
      allowTextOnly = optional(bool)
    }))
    endDateTime                 = optional(string)
    expiryDateTime              = optional(string)
    externalId                  = optional(string)
    isBroadcast                 = optional(bool)
    isEndToEndEncryptionEnabled = optional(bool)
    isEntryExitAnnounced        = optional(bool)
    joinMeetingIdSettings = optional(object({
      odata_type         = optional(string, "#microsoft.graph.joinMeetingIdSettings")
      isPasscodeRequired = optional(bool)
    }))
    lobbyBypassSettings = optional(object({
      odata_type            = optional(string, "#microsoft.graph.lobbyBypassSettings")
      isDialInBypassEnabled = optional(bool)
      scope                 = optional(string)
    }))
    meetingOptionsWebUrl     = optional(string)
    meetingSpokenLanguageTag = optional(string)
    meetingTemplateId        = optional(string)
    participants = optional(object({
      odata_type = optional(string, "#microsoft.graph.meetingParticipants")
      attendees  = optional(any)
      organizer  = optional(any)
    }))
    recordAutomatically = optional(bool)
    sensitivityLabelAssignment = optional(object({
      odata_type         = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")
      sensitivityLabelId = optional(string)
    }))
    shareMeetingChatHistoryDefault = optional(string)
    startDateTime                  = optional(string)
    subject                        = optional(string)
    watermarkProtection = optional(object({
      odata_type                 = optional(string, "#microsoft.graph.watermarkProtectionValues")
      isEnabledForContentSharing = optional(bool)
      isEnabledForVideo          = optional(bool)
    }))
  })
  default = null
}

variable "online_meeting_id" {
  description = "The unique identifier of the online meeting associated with this conversation. The online meeting ID links the conversation to a specific meeting instance."
  type        = string
  default     = null
}

variable "starter" {
  description = "A Viva Engage conversation message."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "organizer", "starterId", "upvoteCount"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
