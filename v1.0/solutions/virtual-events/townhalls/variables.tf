variable "audience" {
  description = "The audience to whom the town hall is visible. The possible values are: everyone, organization, and unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.audience == null ? true : contains(["everyone", "organization", "unknownFutureValue"], var.audience)
    error_message = "audience must be one of the documented enum values."
  }
}

variable "capacity" {
  description = "Represents the expected number of attendees for the town hall."
  type        = number
  default     = null
}

variable "co_organizers" {
  description = "Identity information of the coorganizers of the town hall."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.communicationsUserIdentity")
    displayName = optional(string)
    id          = optional(string)
    tenantId    = optional(string)
  }))
  default = null
}

variable "created_by" {
  description = "The identity information for the creator of the virtual event. Inherited from virtualEvent."
  type = object({
    odata_type                     = optional(string, "#microsoft.graph.communicationsIdentitySet")
    application                    = optional(any)
    applicationInstance            = optional(any)
    assertedIdentity               = optional(any)
    azureCommunicationServicesUser = optional(any)
    device                         = optional(any)
    encrypted                      = optional(any)
    endpointType                   = optional(string)
    guest                          = optional(any)
    onPremises                     = optional(any)
    phone                          = optional(any)
    user                           = optional(any)
  })
  default = null
}

variable "description" {
  description = "A description of the virtual event."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.itemBody")
    content     = optional(string)
    contentType = optional(string)
  })
  default = null
}

variable "display_name" {
  description = "The display name of the virtual event."
  type        = string
  default     = null
}

variable "end_date_time" {
  description = "The end time of the virtual event. The timeZone property can be set to any of the time zones currently supported by Windows. For details on how to get all available time zones using PowerShell, see Get-TimeZone."
  type = object({
    odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
    dateTime   = optional(string)
    timeZone   = optional(string)
  })
  default = null
}

variable "external_event_information" {
  description = "The external information of a virtual event. Returned only for event organizers or coorganizers; otherwise, null."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.virtualEventExternalInformation")
    externalEventId = optional(string)
  }))
  default = null
}

variable "invited_attendees" {
  description = "The attendees invited to the town hall. The supported identities are: communicationsUserIdentity and communicationsGuestIdentity."
  type        = any
  default     = null
}

variable "is_invite_only" {
  description = "Indicates whether the town hall is only open to invited people and groups within your organization. The isInviteOnly property can only be true if the value of the audience property is set to organization."
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
  default     = "#microsoft.graph.virtualEventTownhall"
  nullable    = false
}

variable "presenters" {
  description = "The virtual event presenters."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.virtualEventPresenter")
    email      = optional(string)
    identity   = optional(any)
    presenterDetails = optional(object({
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
    }))
  }))
  default = null
}

variable "registration_configuration" {
  description = "Registration configuration of the town hall."
  type        = any
  default     = null
}

variable "registrations" {
  description = "Registration records of the town hall."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.virtualEventRegistration")
    cancelationDateTime = optional(string)
    email               = optional(string)
    externalRegistrationInformation = optional(object({
      odata_type     = optional(string, "#microsoft.graph.virtualEventExternalRegistrationInformation")
      referrer       = optional(string)
      registrationId = optional(string)
    }))
    firstName            = optional(string)
    lastName             = optional(string)
    preferredLanguage    = optional(string)
    preferredTimezone    = optional(string)
    registrationDateTime = optional(string)
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
      recordAutomatically      = optional(bool)
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
    })))
    userId = optional(string)
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
    recordAutomatically      = optional(bool)
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

variable "settings" {
  description = "The virtual event settings."
  type = object({
    odata_type                         = optional(string, "#microsoft.graph.virtualEventSettings")
    isAttendeeEmailNotificationEnabled = optional(bool)
  })
  default = null
}

variable "start_date_time" {
  description = "Start time of the virtual event. The timeZone property can be set to any of the time zones currently supported by Windows. For details on how to get all available time zones using PowerShell, see Get-TimeZone."
  type = object({
    odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
    dateTime   = optional(string)
    timeZone   = optional(string)
  })
  default = null
}

variable "status" {
  description = "The status of the virtual event. The possible values are: draft, published, canceled, and unknownFutureValue."
  type        = string
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
