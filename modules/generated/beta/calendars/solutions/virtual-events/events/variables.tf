variable "created_by" {
  description = "The identity information for the creator of the virtual event. Inherited from virtualEvent."
  type        = any
  default     = null
}

variable "description" {
  description = "A description of the virtual event."
  type        = any
  default     = null
}

variable "display_name" {
  description = "The display name of the virtual event."
  type        = string
  default     = null
}

variable "end_date_time" {
  description = "The end time of the virtual event. The timeZone property can be set to any of the time zones currently supported by Windows. For details on how to get all available time zones using PowerShell, see Get-TimeZone."
  type        = any
  default     = null
}

variable "external_event_information" {
  description = "The external information of a virtual event. Returned only for event organizers or coorganizers; otherwise, null."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.virtualEventExternalInformation")
    externalEventId = optional(string)
  }))
  default = null
}

variable "is_registration_enabled" {
  description = "Microsoft Graph isRegistrationEnabled property."
  type        = bool
  default     = null
}

variable "is_registration_required" {
  description = "Indicates whether attendee registration is enabled for the virtual event."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.virtualEvent"
  nullable    = false
}

variable "presenters" {
  description = "The virtual event presenters."
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

variable "sessions" {
  description = "The sessions for the virtual event."
  type = list(object({
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
    presenters = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.virtualEventPresenter")
      email            = optional(string)
      identity         = optional(any)
      presenterDetails = optional(any)
      sessions         = optional(any)
    })))
    recordAutomatically = optional(bool)
    registrations = optional(list(object({
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
      registrationQuestionAnswers     = optional(any)
      sessions                        = optional(any)
      userId                          = optional(string)
    })))
    sensitivityLabelAssignment     = optional(any)
    shareMeetingChatHistoryDefault = optional(any)
    startDateTime                  = optional(any)
    subject                        = optional(string)
    videoOnDemandWebUrl            = optional(string)
    watermarkProtection            = optional(any)
  }))
  default = null
}

variable "settings" {
  description = "The virtual event settings."
  type        = any
  default     = null
}

variable "start_date_time" {
  description = "Start time of the virtual event. The timeZone property can be set to any of the time zones currently supported by Windows. For details on how to get all available time zones using PowerShell, see Get-TimeZone."
  type        = any
  default     = null
}

variable "status" {
  description = "The status of the virtual event. The possible values are: draft, published, canceled, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["draft", "published", "canceled", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
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
