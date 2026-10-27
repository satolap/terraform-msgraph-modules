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

  validation {
    condition     = (var.presenter_details == null ? true : alltrue([(var.presenter_details["bio"] == null ? true : alltrue([(var.presenter_details["bio"]["contentType"] == null ? true : alltrue([(var.presenter_details["bio"]["contentType"] == null ? true : contains(["text", "html"], var.presenter_details["bio"]["contentType"]))]))]))]))
    error_message = "presenter_details: nested required attributes must be non-null and enum values must be supported input members."
  }
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

  validation {
    condition     = (var.sessions == null ? true : alltrue([alltrue([for input0 in var.sessions : (input0 == null ? true : alltrue([(input0["allowLiveShare"] == null ? true : alltrue([(input0["allowLiveShare"] == null ? true : contains(["enabled", "disabled"], input0["allowLiveShare"]))])), (input0["allowMeetingChat"] == null ? true : alltrue([(input0["allowMeetingChat"] == null ? true : contains(["enabled", "disabled", "limited"], input0["allowMeetingChat"]))])), (input0["allowedLobbyAdmitters"] == null ? true : alltrue([(input0["allowedLobbyAdmitters"] == null ? true : contains(["organizerAndCoOrganizersAndPresenters", "organizerAndCoOrganizers"], input0["allowedLobbyAdmitters"]))])), (input0["allowedPresenters"] == null ? true : alltrue([(input0["allowedPresenters"] == null ? true : contains(["everyone", "organization", "roleIsPresenter", "organizer"], input0["allowedPresenters"]))])), (input0["anonymizeIdentityForRoles"] == null ? true : alltrue([alltrue([for input2 in input0["anonymizeIdentityForRoles"] : (input2 == null ? true : alltrue([(input2 == null ? true : contains(["attendee", "presenter", "producer"], input2))]))])])), (input0["lobbyBypassSettings"] == null ? true : alltrue([(input0["lobbyBypassSettings"]["scope"] == null ? true : alltrue([(input0["lobbyBypassSettings"]["scope"] == null ? true : contains(["organizer", "organization", "organizationAndFederated", "everyone"], input0["lobbyBypassSettings"]["scope"]))]))])), (input0["shareMeetingChatHistoryDefault"] == null ? true : alltrue([(input0["shareMeetingChatHistoryDefault"] == null ? true : contains(["none", "all"], input0["shareMeetingChatHistoryDefault"]))]))]))])]))
    error_message = "sessions: nested required attributes must be non-null and enum values must be supported input members."
  }
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
