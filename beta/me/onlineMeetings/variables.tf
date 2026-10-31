variable "allowAttendeeToEnableCamera" {
  description = "Indicates whether attendees can turn on their camera."
  type        = bool
  default     = null
}

variable "allowAttendeeToEnableMic" {
  description = "Indicates whether attendees can turn on their microphone."
  type        = bool
  default     = null
}

variable "allowBreakoutRooms" {
  description = "Indicates whether breakout rooms are enabled for the meeting."
  type        = bool
  default     = null
}

variable "allowCopyingAndSharingMeetingContent" {
  description = "Indicates whether copying and sharing meeting content is enabled for the meeting."
  type        = bool
  default     = null
}

variable "allowLiveShare" {
  description = "Indicates whether live share is enabled for the meeting. The possible values are: enabled, disabled, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.allowLiveShare == null ? true : contains(["enabled", "disabled"], var.allowLiveShare)
    error_message = "allowLiveShare must be one of the documented enum values."
  }
}

variable "allowMeetingChat" {
  description = "Specifies the mode of meeting chat. The possible values are: enabled, disabled, limited, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.allowMeetingChat == null ? true : contains(["enabled", "disabled", "limited"], var.allowMeetingChat)
    error_message = "allowMeetingChat must be one of the documented enum values."
  }
}

variable "allowParticipantsToChangeName" {
  description = "Specifies if participants are allowed to rename themselves in an instance of the meeting."
  type        = bool
  default     = null
}

variable "allowPowerPointSharing" {
  description = "Indicates whether PowerPoint live is enabled for the meeting."
  type        = bool
  default     = null
}

variable "allowRecording" {
  description = "Indicates whether recording is enabled for the meeting."
  type        = bool
  default     = null
}

variable "allowTeamworkReactions" {
  description = "Indicates if Teams reactions are enabled for the meeting."
  type        = bool
  default     = null
}

variable "allowTranscription" {
  description = "Indicates whether transcription is enabled for the meeting."
  type        = bool
  default     = null
}

variable "allowWhiteboard" {
  description = "Indicates whether whiteboard is enabled for the meeting."
  type        = bool
  default     = null
}

variable "allowedLobbyAdmitters" {
  description = "Specifies the users who can admit from the lobby. The possible values are: organizerAndCoOrganizersAndPresenters, organizerAndCoOrganizers, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.allowedLobbyAdmitters == null ? true : contains(["organizerAndCoOrganizersAndPresenters", "organizerAndCoOrganizers"], var.allowedLobbyAdmitters)
    error_message = "allowedLobbyAdmitters must be one of the documented enum values."
  }
}

variable "allowedPresenters" {
  description = "Specifies who can be a presenter in a meeting. The possible values are: everyone, organization, roleIsPresenter, organizer, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.allowedPresenters == null ? true : contains(["everyone", "organization", "roleIsPresenter", "organizer"], var.allowedPresenters)
    error_message = "allowedPresenters must be one of the documented enum values."
  }
}

variable "anonymizeIdentityForRoles" {
  description = "Specifies whose identity is anonymized in the meeting. The possible values are: attendee. The attendee value can't be removed through a PATCH operation once added."
  type        = list(string)
  default     = null

  validation {
    condition     = (var.anonymizeIdentityForRoles == null ? true : alltrue([alltrue([for input0 in var.anonymizeIdentityForRoles : (input0 == null ? true : alltrue([(input0 == null ? true : contains(["attendee", "presenter", "producer"], input0))]))])]))
    error_message = "anonymizeIdentityForRoles: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "broadcastRecording" {
  description = "Microsoft Graph broadcastRecording property."
  type        = string
  default     = null
}

variable "broadcastSettings" {
  description = "Settings related to a live event."
  type = object({
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
  })
  default = null

  validation {
    condition     = (var.broadcastSettings == null ? true : alltrue([(var.broadcastSettings["allowedAudience"] == null ? true : alltrue([(var.broadcastSettings["allowedAudience"] == null ? true : contains(["roleIsAttendee", "organization", "everyone"], var.broadcastSettings["allowedAudience"]))]))]))
    error_message = "broadcastSettings: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "capabilities" {
  description = "The list of meeting capabilities. The possible values are: questionAndAnswer,unknownFutureValue."
  type        = list(string)
  default     = null

  validation {
    condition     = (var.capabilities == null ? true : alltrue([alltrue([for input0 in var.capabilities : (input0 == null ? true : alltrue([(input0 == null ? true : contains(["questionAndAnswer"], input0))]))])]))
    error_message = "capabilities: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "chatInfo" {
  description = "The chat information associated with this online meeting."
  type = object({
    odata_type          = optional(string, "#microsoft.graph.chatInfo")
    messageId           = optional(string)
    replyChainMessageId = optional(string)
    threadId            = optional(string)
  })
  default = null
}

variable "chatRestrictions" {
  description = "Specifies the configuration settings for meeting chat restrictions."
  type = object({
    odata_type    = optional(string, "#microsoft.graph.chatRestrictions")
    allowTextOnly = optional(bool)
  })
  default = null
}

variable "endDateTime" {
  description = "The meeting end time in UTC. Required when you create an online meeting."
  type        = string
  default     = null
}

variable "expiryDateTime" {
  description = "Indicates the date and time when the meeting resource expires. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "externalId" {
  description = "The external ID that is a custom identifier. Optional."
  type        = string
  default     = null
}

variable "isBroadcast" {
  description = "Indicates whether this event is a Teams live event."
  type        = bool
  default     = null
}

variable "isEndToEndEncryptionEnabled" {
  description = "Indicates whether end-to-end encryption (E2EE) is enabled for the online meeting."
  type        = bool
  default     = null
}

variable "isEntryExitAnnounced" {
  description = "Indicates whether to announce when callers join or leave."
  type        = bool
  default     = null
}

variable "joinMeetingIdSettings" {
  description = "Specifies the joinMeetingId, the meeting passcode, and the requirement for the passcode. Once an onlineMeeting is created, the joinMeetingIdSettings can't be modified. To make any changes to this property, the meeting needs to be canceled and a new one needs to be created."
  type = object({
    odata_type         = optional(string, "#microsoft.graph.joinMeetingIdSettings")
    isPasscodeRequired = optional(bool)
  })
  default = null
}

variable "joinUrl" {
  description = "Microsoft Graph joinUrl property."
  type        = string
  default     = null
}

variable "lobbyBypassSettings" {
  description = "Specifies which participants can bypass the meeting lobby."
  type = object({
    odata_type            = optional(string, "#microsoft.graph.lobbyBypassSettings")
    isDialInBypassEnabled = optional(bool)
    scope                 = optional(string)
  })
  default = null

  validation {
    condition     = (var.lobbyBypassSettings == null ? true : alltrue([(var.lobbyBypassSettings["scope"] == null ? true : alltrue([(var.lobbyBypassSettings["scope"] == null ? true : contains(["organizer", "organization", "organizationAndFederated", "everyone"], var.lobbyBypassSettings["scope"]))]))]))
    error_message = "lobbyBypassSettings: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "meetingOptionsWebUrl" {
  description = "Provides the URL to the Teams meeting options page for the specified meeting. This link allows only the organizer to configure meeting settings."
  type        = string
  default     = null
}

variable "meetingSpokenLanguageTag" {
  description = "Specifies the spoken language used during the meeting for recording and transcription purposes."
  type        = string
  default     = null
}

variable "meetingTemplateId" {
  description = "The ID of the meeting template."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.onlineMeeting"
  nullable    = false
}

variable "participants" {
  description = "The participants associated with the online meeting, including the organizer and the attendees."
  type = object({
    odata_type   = optional(string, "#microsoft.graph.meetingParticipants")
    attendees    = optional(any)
    contributors = optional(any)
    organizer    = optional(any)
    producers    = optional(any)
  })
  default = null
}

variable "recordAutomatically" {
  description = "Indicates whether to record the meeting automatically."
  type        = bool
  default     = null
}

variable "registration" {
  description = "The registration that is enabled for an online meeting. One online meeting can only have one registration enabled."
  type        = any
  default     = null
}

variable "sensitivityLabelAssignment" {
  description = "Specifies the sensitivity label applied to the Teams meeting."
  type = object({
    odata_type         = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")
    sensitivityLabelId = optional(string)
  })
  default = null
}

variable "shareMeetingChatHistoryDefault" {
  description = "Specifies whether meeting chat history is shared with participants.  The possible values are: all, none, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.shareMeetingChatHistoryDefault == null ? true : contains(["none", "all"], var.shareMeetingChatHistoryDefault)
    error_message = "shareMeetingChatHistoryDefault must be one of the documented enum values."
  }
}

variable "startDateTime" {
  description = "The meeting start time in UTC. Required when you create an online meeting."
  type        = string
  default     = null
}

variable "subject" {
  description = "The subject of the online meeting."
  type        = string
  default     = null
}

variable "watermarkProtection" {
  description = "Specifies whether the client application should apply a watermark to a content type."
  type = object({
    odata_type                 = optional(string, "#microsoft.graph.watermarkProtectionValues")
    isEnabledForContentSharing = optional(bool)
    isEnabledForVideo          = optional(bool)
  })
  default = null
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["aiInsights", "alternativeRecording", "attendanceReports", "attendeeReport", "audioConferencing", "cloudVideoInteropInfo", "creationDateTime", "id", "joinInformation", "joinWebUrl", "meetingAttendanceReport", "meetingType", "recording", "recordings", "transcripts", "videoTeleconferenceId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
