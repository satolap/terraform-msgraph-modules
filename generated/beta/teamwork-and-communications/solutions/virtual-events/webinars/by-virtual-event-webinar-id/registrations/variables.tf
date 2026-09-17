variable "virtual_event_webinar_id" {
  description = "The unique identifier of virtualEventWebinar"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.virtual_event_webinar_id)) > 0
    error_message = "virtual_event_webinar_id must not be empty."
  }
}

variable "cancelation_date_time" {
  description = "Date and time when the registrant cancels their registration for the virtual event. Only appears when applicable. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "email" {
  description = "Email address of the registrant."
  type        = string
  default     = null
}

variable "external_registration_information" {
  description = "The external information for a virtual event registration."
  type        = any
  default     = null
}

variable "first_name" {
  description = "First name of the registrant."
  type        = string
  default     = null
}

variable "last_name" {
  description = "Last name of the registrant."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.virtualEventRegistration"
  nullable    = false
}

variable "preferred_language" {
  description = "The registrant's preferred language."
  type        = string
  default     = null
}

variable "preferred_timezone" {
  description = "The registrant's time zone details."
  type        = string
  default     = null
}

variable "registrant_video_on_demand_web_url" {
  description = "Microsoft Graph registrantVideoOnDemandWebUrl property."
  type        = string
  default     = null
}

variable "registration_date_time" {
  description = "Date and time when the registrant registers for the virtual event. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "registration_question_answers" {
  description = "The registrant's answer to the registration questions."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.virtualEventRegistrationQuestionAnswer")
    booleanValue      = optional(bool)
    displayName       = optional(string)
    multiChoiceValues = optional(list(string))
    questionId        = optional(string)
    value             = optional(string)
  }))
  default = null
}

variable "sessions" {
  description = "Sessions for a registration."
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

variable "user_id" {
  description = "The registrant's ID in Microsoft Entra ID. Only appears when the registrant is registered in Microsoft Entra ID."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
