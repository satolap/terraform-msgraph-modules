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
      presenters               = optional(any)
      recordAutomatically      = optional(bool)
      registrations            = optional(any)
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
  description = "The status of the virtual event. The possible values are: draft, published, canceled, unknownFutureValue."
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
