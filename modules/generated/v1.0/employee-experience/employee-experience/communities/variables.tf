variable "description" {
  description = "The description of the community. The maximum length is 1,024 characters."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the community. The maximum length is 255 characters."
  type        = string
  default     = null
}

variable "group" {
  description = "The Microsoft 365 group that manages the membership of this community."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.community"
  nullable    = false
}

variable "owners" {
  description = "The admins of the community. Limited to 100 users. If this property isn't specified when you create the community, the calling user is automatically assigned as the community owner."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.user")
    aboutMe        = optional(string)
    accountEnabled = optional(bool)
    ageGroup       = optional(string)
    appRoleAssignments = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.appRoleAssignment")
      appRoleId           = optional(string)
      deletedDateTime     = optional(string)
      principalId         = optional(string)
      resourceDisplayName = optional(string)
      resourceId          = optional(string)
    })))
    assignedLicenses = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.assignedLicense")
      disabledPlans = optional(list(string))
      skuId         = optional(string)
    })))
    authentication = optional(any)
    authorizationInfo = optional(object({
      odata_type         = optional(string, "#microsoft.graph.authorizationInfo")
      certificateUserIds = optional(list(string))
    }))
    birthday = optional(string)
    chats = optional(list(object({
      odata_type              = optional(string, "#microsoft.graph.chat")
      chatType                = optional(string)
      installedApps           = optional(any)
      lastMessagePreview      = optional(any)
      members                 = optional(any)
      messages                = optional(any)
      migrationMode           = optional(string)
      originalCreatedDateTime = optional(string)
      permissionGrants        = optional(any)
      pinnedMessages          = optional(any)
      tabs                    = optional(any)
      targetedMessages        = optional(any)
      topic                   = optional(string)
      viewpoint = optional(object({
        odata_type              = optional(string, "#microsoft.graph.chatViewpoint")
        isHidden                = optional(bool)
        lastMessageReadDateTime = optional(string)
      }))
    })))
    city                                  = optional(string)
    cloudClipboard                        = optional(any)
    companyName                           = optional(string)
    consentProvidedForMinor               = optional(string)
    country                               = optional(string)
    customSecurityAttributes              = optional(any)
    deletedDateTime                       = optional(string)
    department                            = optional(string)
    deviceEnrollmentLimit                 = optional(number)
    deviceManagementTroubleshootingEvents = optional(any)
    displayName                           = optional(string)
    employeeExperience                    = optional(any)
    employeeHireDate                      = optional(string)
    employeeId                            = optional(string)
    employeeLeaveDateTime                 = optional(string)
    employeeOrgData = optional(object({
      odata_type = optional(string, "#microsoft.graph.employeeOrgData")
      costCenter = optional(string)
      division   = optional(string)
    }))
    employeeType                    = optional(string)
    externalUserState               = optional(string)
    externalUserStateChangeDateTime = optional(string)
    faxNumber                       = optional(string)
    followedSites = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.site")
      analytics    = optional(any)
      columns      = optional(any)
      contentTypes = optional(any)
      description  = optional(string)
      drive        = optional(any)
      drives       = optional(any)
      error = optional(object({
        odata_type = optional(string, "#microsoft.graph.publicError")
        code       = optional(string)
        details    = optional(any)
        innerError = optional(any)
        message    = optional(string)
        target     = optional(string)
      }))
      externalColumns = optional(any)
      items           = optional(any)
      lists           = optional(any)
      name            = optional(string)
      onenote         = optional(any)
      operations      = optional(any)
      pages           = optional(any)
      parentReference = optional(object({
        odata_type = optional(string, "#microsoft.graph.itemReference")
        driveType  = optional(string)
        shareId    = optional(string)
        siteId     = optional(string)
      }))
      permissions = optional(any)
      sites       = optional(any)
      termStore   = optional(any)
      termStores  = optional(any)
    })))
    givenName = optional(string)
    hireDate  = optional(string)
    identities = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.objectIdentity")
      issuer           = optional(string)
      issuerAssignedId = optional(string)
      signInType       = optional(string)
    })))
    identityParentId        = optional(string)
    inferenceClassification = optional(any)
    interests               = optional(list(string))
    isResourceAccount       = optional(bool)
    jobTitle                = optional(string)
    joinedTeams = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.team")
      allChannels      = optional(any)
      channels         = optional(any)
      classification   = optional(string)
      createdDateTime  = optional(string)
      description      = optional(string)
      displayName      = optional(string)
      firstChannelName = optional(string)
      funSettings = optional(object({
        odata_type            = optional(string, "#microsoft.graph.teamFunSettings")
        allowCustomMemes      = optional(bool)
        allowGiphy            = optional(bool)
        allowStickersAndMemes = optional(bool)
        giphyContentRating    = optional(string)
      }))
      group = optional(any)
      guestSettings = optional(object({
        odata_type                = optional(string, "#microsoft.graph.teamGuestSettings")
        allowCreateUpdateChannels = optional(bool)
        allowDeleteChannels       = optional(bool)
      }))
      incomingChannels = optional(any)
      installedApps    = optional(any)
      internalId       = optional(string)
      memberSettings = optional(object({
        odata_type                        = optional(string, "#microsoft.graph.teamMemberSettings")
        allowAddRemoveApps                = optional(bool)
        allowCreatePrivateChannels        = optional(bool)
        allowCreateUpdateChannels         = optional(bool)
        allowCreateUpdateRemoveConnectors = optional(bool)
        allowCreateUpdateRemoveTabs       = optional(bool)
        allowDeleteChannels               = optional(bool)
      }))
      members = optional(any)
      messagingSettings = optional(object({
        odata_type               = optional(string, "#microsoft.graph.teamMessagingSettings")
        allowChannelMentions     = optional(bool)
        allowOwnerDeleteMessages = optional(bool)
        allowTeamMentions        = optional(bool)
        allowUserDeleteMessages  = optional(bool)
        allowUserEditMessages    = optional(bool)
      }))
      operations       = optional(any)
      permissionGrants = optional(any)
      photo            = optional(any)
      primaryChannel   = optional(any)
      schedule         = optional(any)
      specialization   = optional(string)
      summary = optional(object({
        odata_type   = optional(string, "#microsoft.graph.teamSummary")
        guestsCount  = optional(number)
        membersCount = optional(number)
        ownersCount  = optional(number)
      }))
      tags       = optional(any)
      template   = optional(any)
      tenantId   = optional(string)
      visibility = optional(string)
      webUrl     = optional(string)
    })))
    lastPasswordChangeDateTime = optional(string)
    mail                       = optional(string)
    mailNickname               = optional(string)
    mailboxSettings = optional(object({
      odata_type    = optional(string, "#microsoft.graph.mailboxSettings")
      archiveFolder = optional(string)
      automaticRepliesSetting = optional(object({
        odata_type           = optional(string, "#microsoft.graph.automaticRepliesSetting")
        externalAudience     = optional(string)
        externalReplyMessage = optional(string)
        internalReplyMessage = optional(string)
        scheduledEndDateTime = optional(object({
          odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
          dateTime   = optional(string)
          timeZone   = optional(string)
        }))
        scheduledStartDateTime = optional(object({
          odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
          dateTime   = optional(string)
          timeZone   = optional(string)
        }))
        status = optional(string)
      }))
      dateFormat                            = optional(string)
      delegateMeetingMessageDeliveryOptions = optional(string)
      language = optional(object({
        odata_type  = optional(string, "#microsoft.graph.localeInfo")
        displayName = optional(string)
        locale      = optional(string)
      }))
      timeFormat = optional(string)
      timeZone   = optional(string)
      workingHours = optional(object({
        odata_type = optional(string, "#microsoft.graph.workingHours")
        daysOfWeek = optional(list(string))
        endTime    = optional(string)
        startTime  = optional(string)
        timeZone   = optional(any)
      }))
    }))
    managedAppRegistrations = optional(list(object({
      odata_type           = string
      appIdentifier        = optional(any)
      applicationVersion   = optional(string)
      appliedPolicies      = optional(any)
      createdDateTime      = optional(string)
      deviceName           = optional(string)
      deviceTag            = optional(string)
      deviceType           = optional(string)
      flaggedReasons       = optional(list(string))
      intendedPolicies     = optional(any)
      lastSyncDateTime     = optional(string)
      managementSdkVersion = optional(string)
      operations           = optional(any)
      platformVersion      = optional(string)
      userId               = optional(string)
      version              = optional(string)
    })))
    managedDevices = optional(list(object({
      odata_type                   = optional(string, "#microsoft.graph.managedDevice")
      deviceCategory               = optional(any)
      deviceCompliancePolicyStates = optional(any)
      deviceConfigurationStates    = optional(any)
      logCollectionRequests        = optional(any)
      managedDeviceName            = optional(string)
      managedDeviceOwnerType       = optional(string)
      notes                        = optional(string)
      users                        = optional(any)
    })))
    mySite = optional(string)
    oauth2PermissionGrants = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.oAuth2PermissionGrant")
      clientId    = optional(string)
      consentType = optional(string)
      principalId = optional(string)
      resourceId  = optional(string)
      scope       = optional(string)
    })))
    officeLocation        = optional(string)
    onPremisesImmutableId = optional(string)
    onPremisesProvisioningErrors = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.onPremisesProvisioningError")
      category             = optional(string)
      occurredDateTime     = optional(string)
      propertyCausingError = optional(string)
      value                = optional(string)
    })))
    onPremisesSyncBehavior = optional(any)
    onenote                = optional(any)
    onlineMeetings = optional(list(object({
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
        odata_type                 = optional(string, "#microsoft.graph.broadcastMeetingSettings")
        allowedAudience            = optional(string)
        captions                   = optional(any)
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
    })))
    otherMails       = optional(list(string))
    outlook          = optional(any)
    passwordPolicies = optional(string)
    passwordProfile = optional(object({
      odata_type                           = optional(string, "#microsoft.graph.passwordProfile")
      forceChangePasswordNextSignIn        = optional(bool)
      forceChangePasswordNextSignInWithMfa = optional(bool)
      password                             = optional(string)
    }))
    pastProjects = optional(list(string))
    permissionGrants = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
      deletedDateTime = optional(string)
    })))
    postalCode            = optional(string)
    preferredDataLocation = optional(string)
    preferredLanguage     = optional(string)
    preferredName         = optional(string)
    presence              = optional(any)
    print = optional(object({
      odata_type = optional(string, "#microsoft.graph.userPrint")
      recentPrinterShares = optional(list(object({
        odata_type      = optional(string, "#microsoft.graph.printerShare")
        allowAllUsers   = optional(bool)
        allowedGroups   = optional(any)
        allowedUsers    = optional(any)
        capabilities    = optional(any)
        defaults        = optional(any)
        displayName     = optional(string)
        isAcceptingJobs = optional(bool)
        jobs            = optional(any)
        location        = optional(any)
        manufacturer    = optional(string)
        model           = optional(string)
        printer         = optional(any)
        status          = optional(any)
        viewPoint       = optional(any)
      })))
    }))
    responsibilities = optional(list(string))
    schools          = optional(list(string))
    scopedRoleMemberOf = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.scopedRoleMembership")
      administrativeUnitId = optional(string)
      roleId               = optional(string)
      roleMemberInfo       = optional(any)
    })))
    serviceProvisioningErrors = optional(any)
    settings                  = optional(any)
    showInAddressList         = optional(bool)
    skills                    = optional(list(string))
    sponsors                  = optional(any)
    state                     = optional(string)
    streetAddress             = optional(string)
    surname                   = optional(string)
    todo                      = optional(any)
    transitiveMemberOf        = optional(any)
    usageLocation             = optional(string)
    userPrincipalName         = optional(string)
    userType                  = optional(string)
  }))
  default   = null
  sensitive = true

  validation {
    condition     = (var.owners == null ? true : alltrue([for item0 in var.owners : (item0 == null ? true : alltrue([(item0["managedAppRegistrations"] == null ? true : alltrue([for item2 in item0["managedAppRegistrations"] : (item2 == null ? true : alltrue([(item2["odata_type"] == null ? false : contains(["#microsoft.graph.androidManagedAppRegistration", "#microsoft.graph.iosManagedAppRegistration"], item2["odata_type"]))]))]))]))]))
    error_message = "owners: every nested odata_type of an abstract Graph type must name a concrete type."
  }
}

variable "privacy" {
  description = "Types of communityPrivacy."
  type        = string
  default     = null

  validation {
    condition     = var.privacy == null ? true : contains(["public", "private", "unknownFutureValue"], var.privacy)
    error_message = "privacy must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["groupId", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
