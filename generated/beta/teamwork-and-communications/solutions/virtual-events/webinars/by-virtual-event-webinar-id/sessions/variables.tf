variable "virtual_event_webinar_id" {
  description = "The unique identifier of virtualEventWebinar"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.virtual_event_webinar_id)) > 0
    error_message = "virtual_event_webinar_id must not be empty."
  }
}

variable "allow_attendee_to_enable_camera" {
  description = "Indicates whether attendees can turn on their camera."
  type        = bool
  default     = null
}

variable "allow_attendee_to_enable_mic" {
  description = "Indicates whether attendees can turn on their microphone."
  type        = bool
  default     = null
}

variable "allow_breakout_rooms" {
  description = "Indicates whether breakout rooms are enabled for the meeting."
  type        = bool
  default     = null
}

variable "allow_copying_and_sharing_meeting_content" {
  description = "Indicates whether copying and sharing meeting content is enabled for the meeting."
  type        = bool
  default     = null
}

variable "allow_live_share" {
  description = "Indicates whether live share is enabled for the meeting. The possible values are: enabled, disabled, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.allow_live_share == null ? true : contains(["enabled", "disabled", "unknownFutureValue"], var.allow_live_share)
    error_message = "allow_live_share must be one of the documented enum values."
  }
}

variable "allow_meeting_chat" {
  description = "Specifies the mode of meeting chat. The possible values are: enabled, disabled, limited, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.allow_meeting_chat == null ? true : contains(["enabled", "disabled", "limited", "unknownFutureValue"], var.allow_meeting_chat)
    error_message = "allow_meeting_chat must be one of the documented enum values."
  }
}

variable "allow_participants_to_change_name" {
  description = "Specifies if participants are allowed to rename themselves in an instance of the meeting."
  type        = bool
  default     = null
}

variable "allow_power_point_sharing" {
  description = "Indicates whether PowerPoint live is enabled for the meeting."
  type        = bool
  default     = null
}

variable "allow_recording" {
  description = "Indicates whether recording is enabled for the meeting."
  type        = bool
  default     = null
}

variable "allow_teamwork_reactions" {
  description = "Indicates if Teams reactions are enabled for the meeting."
  type        = bool
  default     = null
}

variable "allow_transcription" {
  description = "Indicates whether transcription is enabled for the meeting."
  type        = bool
  default     = null
}

variable "allow_whiteboard" {
  description = "Indicates whether whiteboard is enabled for the meeting."
  type        = bool
  default     = null
}

variable "allowed_lobby_admitters" {
  description = "Specifies the users who can admit from the lobby. The possible values are: organizerAndCoOrganizersAndPresenters, organizerAndCoOrganizers, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.allowed_lobby_admitters == null ? true : contains(["organizerAndCoOrganizersAndPresenters", "organizerAndCoOrganizers", "unknownFutureValue"], var.allowed_lobby_admitters)
    error_message = "allowed_lobby_admitters must be one of the documented enum values."
  }
}

variable "allowed_presenters" {
  description = "Specifies who can be a presenter in a meeting. The possible values are: everyone, organization, roleIsPresenter, organizer, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.allowed_presenters == null ? true : contains(["everyone", "organization", "roleIsPresenter", "organizer", "unknownFutureValue"], var.allowed_presenters)
    error_message = "allowed_presenters must be one of the documented enum values."
  }
}

variable "anonymize_identity_for_roles" {
  description = "Specifies whose identity is anonymized in the meeting. The possible values are: attendee. The attendee value can't be removed through a PATCH operation once added."
  type        = any
  default     = null
}

variable "capacity" {
  description = "Represents the expected number of attendees for town hall session."
  type        = number
  default     = null
}

variable "chat_info" {
  description = "The chat information associated with this online meeting."
  type        = any
  default     = null
}

variable "chat_restrictions" {
  description = "Specifies the configuration settings for meeting chat restrictions."
  type        = any
  default     = null
}

variable "end_date_time" {
  description = "The virtual event session end time."
  type        = any
  default     = null
}

variable "expiry_date_time" {
  description = "Indicates the date and time when the meeting resource expires. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "is_end_to_end_encryption_enabled" {
  description = "Indicates whether end-to-end encryption (E2EE) is enabled for the online meeting."
  type        = bool
  default     = null
}

variable "is_entry_exit_announced" {
  description = "Indicates whether to announce when callers join or leave."
  type        = bool
  default     = null
}

variable "join_meeting_id_settings" {
  description = "Specifies the joinMeetingId, the meeting passcode, and the requirement for the passcode. Once an onlineMeeting is created, the joinMeetingIdSettings can't be modified. To make any changes to this property, the meeting needs to be canceled and a new one needs to be created."
  type        = any
  default     = null
}

variable "lobby_bypass_settings" {
  description = "Specifies which participants can bypass the meeting lobby."
  type        = any
  default     = null
}

variable "meeting_options_web_url" {
  description = "Provides the URL to the Teams meeting options page for the specified meeting. This link allows only the organizer to configure meeting settings."
  type        = string
  default     = null
}

variable "meeting_spoken_language_tag" {
  description = "Specifies the spoken language used during the meeting for recording and transcription purposes."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.virtualEventSession"
  nullable    = false
}

variable "presenters" {
  description = "Microsoft Graph presenters property."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.virtualEventPresenter")
    email            = optional(string)
    identity         = optional(any)
    presenterDetails = optional(any)
    sessions = optional(list(object({
      odata_type                           = optional(string, "#microsoft.graph.virtualEventSession")
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
      anonymizeIdentityForRoles            = optional(any)
      capacity                             = optional(number)
      chatInfo                             = optional(any)
      chatRestrictions                     = optional(any)
      endDateTime                          = optional(any)
      expiryDateTime                       = optional(string)
      isEndToEndEncryptionEnabled          = optional(bool)
      isEntryExitAnnounced                 = optional(bool)
      joinMeetingIdSettings                = optional(any)
      lobbyBypassSettings                  = optional(any)
      meetingOptionsWebUrl                 = optional(string)
      meetingSpokenLanguageTag             = optional(string)
      presenters                           = optional(any)
      recordAutomatically                  = optional(bool)
      registrations                        = optional(any)
      sensitivityLabelAssignment           = optional(any)
      shareMeetingChatHistoryDefault       = optional(any)
      startDateTime                        = optional(any)
      subject                              = optional(string)
      videoOnDemandWebUrl                  = optional(string)
      watermarkProtection                  = optional(any)
    })))
  }))
  default = null
}

variable "record_automatically" {
  description = "Indicates whether to record the meeting automatically."
  type        = bool
  default     = null
}

variable "registrations" {
  description = "Microsoft Graph registrations property."
  type = list(object({
    odata_type                      = optional(string, "#microsoft.graph.virtualEventRegistration")
    cancelationDateTime             = optional(string)
    email                           = optional(string)
    externalRegistrationInformation = optional(any)
    firstName                       = optional(string)
    lastName                        = optional(string)
    preferredLanguage               = optional(string)
    preferredTimezone               = optional(string)
    registrantVideoOnDemandWebUrl   = optional(string)
    registrationDateTime            = optional(string)
    registrationQuestionAnswers = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.virtualEventRegistrationQuestionAnswer")
      booleanValue      = optional(bool)
      displayName       = optional(string)
      multiChoiceValues = optional(list(string))
      questionId        = optional(string)
      value             = optional(string)
    })))
    sessions = optional(list(object({
      odata_type                           = optional(string, "#microsoft.graph.virtualEventSession")
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
      anonymizeIdentityForRoles            = optional(any)
      capacity                             = optional(number)
      chatInfo                             = optional(any)
      chatRestrictions                     = optional(any)
      endDateTime                          = optional(any)
      expiryDateTime                       = optional(string)
      isEndToEndEncryptionEnabled          = optional(bool)
      isEntryExitAnnounced                 = optional(bool)
      joinMeetingIdSettings                = optional(any)
      lobbyBypassSettings                  = optional(any)
      meetingOptionsWebUrl                 = optional(string)
      meetingSpokenLanguageTag             = optional(string)
      presenters                           = optional(any)
      recordAutomatically                  = optional(bool)
      registrations                        = optional(any)
      sensitivityLabelAssignment           = optional(any)
      shareMeetingChatHistoryDefault       = optional(any)
      startDateTime                        = optional(any)
      subject                              = optional(string)
      videoOnDemandWebUrl                  = optional(string)
      watermarkProtection                  = optional(any)
    })))
    userId = optional(string)
  }))
  default = null
}

variable "sensitivity_label_assignment" {
  description = "Specifies the sensitivity label applied to the Teams meeting."
  type        = any
  default     = null
}

variable "share_meeting_chat_history_default" {
  description = "Specifies whether meeting chat history is shared with participants.  The possible values are: all, none, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.share_meeting_chat_history_default == null ? true : contains(["none", "all", "unknownFutureValue"], var.share_meeting_chat_history_default)
    error_message = "share_meeting_chat_history_default must be one of the documented enum values."
  }
}

variable "start_date_time" {
  description = "The virtual event session start time."
  type        = any
  default     = null
}

variable "subject" {
  description = "The subject of the online meeting."
  type        = string
  default     = null
}

variable "video_on_demand_web_url" {
  description = "The URL of the video on demand (VOD) for Microsoft Teams events that allows webinar and town hall organizers to quickly publish and share event recordings."
  type        = string
  default     = null
}

variable "watermark_protection" {
  description = "Specifies whether the client application should apply a watermark to a content type."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["attendanceReports", "audioConferencing", "cloudVideoInteropInfo", "id", "joinInformation", "joinWebUrl", "meetingType", "videoTeleconferenceId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
