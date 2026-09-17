variable "virtual_event_id" {
  description = "The unique identifier of virtualEvent"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.virtual_event_id)) > 0
    error_message = "virtual_event_id must not be empty."
  }
}

variable "email" {
  description = "Email address of the presenter."
  type        = string
  default     = null
}

variable "identity" {
  description = "Identity information of the presenter. The supported identities are: communicationsGuestIdentity and communicationsUserIdentity."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.virtualEventPresenter"
  nullable    = false
}

variable "presenter_details" {
  description = "Other detail information of the presenter. This property returns null when the virtual event type is virtualEventTownhall."
  type        = any
  default     = null
}

variable "sessions" {
  description = "Microsoft Graph sessions property."
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
