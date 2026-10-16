variable "virtual_event_townhall_id" {
  description = "The unique identifier of virtualEventTownhall"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.virtual_event_townhall_id)) > 0
    error_message = "virtual_event_townhall_id must not be empty."
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
  type = object({
    odata_type = optional(string, "#microsoft.graph.virtualEventPresenterDetails")
    bio = optional(object({
      odata_type  = optional(string, "#microsoft.graph.itemBody")
      content     = optional(string)
      contentType = optional(string)
    }))
    company               = optional(string)
    jobTitle              = optional(string)
    linkedInProfileWebUrl = optional(string)
    personalSiteWebUrl    = optional(string)
    photo                 = optional(string)
    twitterProfileWebUrl  = optional(string)
  })
  default = null
}

variable "sessions" {
  description = "Microsoft Graph sessions property."
  type = list(object({
    odata_type                           = optional(string, "#microsoft.graph.virtualEventSession")
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
    anonymizeIdentityForRoles            = optional(list(string))
    capacity                             = optional(number)
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
    endDateTime = optional(object({
      odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
      dateTime   = optional(string)
      timeZone   = optional(string)
    }))
    expiryDateTime              = optional(string)
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
    presenters = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.virtualEventPresenter")
      email      = optional(string)
      identity   = optional(any)
      presenterDetails = optional(object({
        odata_type            = optional(string, "#microsoft.graph.virtualEventPresenterDetails")
        bio                   = optional(any)
        company               = optional(string)
        jobTitle              = optional(string)
        linkedInProfileWebUrl = optional(string)
        personalSiteWebUrl    = optional(string)
        photo                 = optional(string)
        twitterProfileWebUrl  = optional(string)
      }))
      sessions = optional(any)
    })))
    recordAutomatically = optional(bool)
    registrations = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.virtualEventRegistration")
      cancelationDateTime = optional(string)
      email               = optional(string)
      externalRegistrationInformation = optional(object({
        odata_type     = optional(string, "#microsoft.graph.virtualEventExternalRegistrationInformation")
        referrer       = optional(string)
        registrationId = optional(string)
      }))
      firstName                     = optional(string)
      lastName                      = optional(string)
      preferredLanguage             = optional(string)
      preferredTimezone             = optional(string)
      registrantVideoOnDemandWebUrl = optional(string)
      registrationDateTime          = optional(string)
      registrationQuestionAnswers   = optional(any)
      sessions                      = optional(any)
      userId                        = optional(string)
    })))
    sensitivityLabelAssignment = optional(object({
      odata_type         = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")
      sensitivityLabelId = optional(string)
    }))
    shareMeetingChatHistoryDefault = optional(string)
    startDateTime = optional(object({
      odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
      dateTime   = optional(string)
      timeZone   = optional(string)
    }))
    subject             = optional(string)
    videoOnDemandWebUrl = optional(string)
    watermarkProtection = optional(object({
      odata_type                 = optional(string, "#microsoft.graph.watermarkProtectionValues")
      isEnabledForContentSharing = optional(bool)
      isEnabledForVideo          = optional(bool)
    }))
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
