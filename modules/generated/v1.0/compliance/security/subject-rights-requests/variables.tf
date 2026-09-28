variable "approvers" {
  description = "Collection of users who can approve the request. Currently only supported for requests of type delete."
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
    condition     = (var.approvers == null ? true : alltrue([for item0 in var.approvers : (item0 == null ? true : alltrue([(item0["managedAppRegistrations"] == null ? true : alltrue([for item2 in item0["managedAppRegistrations"] : (item2 == null ? true : alltrue([(item2["odata_type"] == null ? false : contains(["#microsoft.graph.androidManagedAppRegistration", "#microsoft.graph.iosManagedAppRegistration"], item2["odata_type"]))]))]))]))]))
    error_message = "approvers: every nested odata_type of an abstract Graph type must name a concrete type."
  }
}

variable "assigned_to" {
  description = "Identity that the request is assigned to."
  type        = any
  default     = null
}

variable "closed_date_time" {
  description = "The date and time when the request was closed. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "collaborators" {
  description = "Collection of users who can collaborate on the request."
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
    condition     = (var.collaborators == null ? true : alltrue([for item0 in var.collaborators : (item0 == null ? true : alltrue([(item0["managedAppRegistrations"] == null ? true : alltrue([for item2 in item0["managedAppRegistrations"] : (item2 == null ? true : alltrue([(item2["odata_type"] == null ? false : contains(["#microsoft.graph.androidManagedAppRegistration", "#microsoft.graph.iosManagedAppRegistration"], item2["odata_type"]))]))]))]))]))
    error_message = "collaborators: every nested odata_type of an abstract Graph type must name a concrete type."
  }
}

variable "content_query" {
  description = "KQL based content query that should be used for search. This property is defined only for APIs accessed using the /security query path and not the /privacy query path."
  type        = string
  default     = null
}

variable "created_by" {
  description = "Identity information for the entity that created the request."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the request was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "data_subject" {
  description = "Information about the data subject."
  type = object({
    odata_type = optional(string, "#microsoft.graph.dataSubject")
    email      = optional(string)
    firstName  = optional(string)
    lastName   = optional(string)
    residency  = optional(string)
  })
  default = null
}

variable "data_subject_type" {
  description = "The type of the data subject. The possible values are: customer, currentEmployee, formerEmployee, prospectiveEmployee, student, teacher, faculty, other, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.data_subject_type == null ? true : contains(["customer", "currentEmployee", "formerEmployee", "prospectiveEmployee", "student", "teacher", "faculty", "other", "unknownFutureValue"], var.data_subject_type)
    error_message = "data_subject_type must be one of the documented enum values."
  }
}

variable "description" {
  description = "Description for the request."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the request."
  type        = string
  default     = null
}

variable "external_id" {
  description = "The external ID for the request that is immutable after creation and is used for tracking the request for the external system. This property is defined only for APIs accessed using the /security query path and not the /privacy query path."
  type        = string
  default     = null
}

variable "history" {
  description = "Collection of history change events."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.subjectRightsRequestHistory")
    changedBy     = optional(any)
    eventDateTime = optional(string)
    stage         = optional(string)
    stageStatus   = optional(string)
    type          = optional(string)
  }))
  default = null
}

variable "include_all_versions" {
  description = "Include all versions of the documents. By default, the current copies of the documents are returned. If SharePoint sites have versioning enabled, including all versions includes the historical copies of the documents. This property is defined only for APIs accessed using the /security query path and not the /privacy query path."
  type        = bool
  default     = null
}

variable "include_authored_content" {
  description = "Include content authored by the data subject. This property is defined only for APIs accessed using the /security query path and not the /privacy query path."
  type        = bool
  default     = null
}

variable "insight" {
  description = "Insight about the request."
  type = object({
    odata_type        = optional(string, "#microsoft.graph.subjectRightsRequestDetail")
    excludedItemCount = optional(number)
    insightCounts = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.keyValuePair")
      name       = optional(string)
      value      = optional(string)
    })))
    itemCount      = optional(number)
    itemNeedReview = optional(number)
    productItemCounts = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.keyValuePair")
      name       = optional(string)
      value      = optional(string)
    })))
    signedOffItemCount = optional(number)
    totalItemSize      = optional(number)
  })
  default = null
}

variable "internal_due_date_time" {
  description = "The date and time when the request is internally due. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "Identity information for the entity that last modified the request."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the request was last modified. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "mailbox_locations" {
  description = "The mailbox locations that should be searched. This property is defined only for APIs accessed using the /security query path and not the /privacy query path."
  type        = any
  default     = null
}

variable "notes" {
  description = "List of notes associated with the request."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.authoredNote")
    author     = optional(any)
    content = optional(object({
      odata_type  = optional(string, "#microsoft.graph.itemBody")
      content     = optional(string)
      contentType = optional(string)
    }))
    createdDateTime = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.subjectRightsRequest"
  nullable    = false
}

variable "pause_after_estimate" {
  description = "Pause the request after estimate has finished. By default, the data estimate runs and then pauses, allowing you to preview results and then select the option to retrieve data in the UI. You can set this property to false if you want it to perform the estimate and then automatically begin with the retrieval of the content. This property is defined only for APIs accessed using the /security query path and not the /privacy query path."
  type        = bool
  default     = null
}

variable "regulations" {
  description = "List of regulations that this request fulfill."
  type        = list(string)
  default     = null
}

variable "site_locations" {
  description = "The SharePoint and OneDrive site locations that should be searched. This property is defined only for APIs accessed using the /security query path and not the /privacy query path."
  type        = any
  default     = null
}

variable "stages" {
  description = "Information about the different stages for the request."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.subjectRightsRequestStageDetail")
    error = optional(object({
      odata_type = optional(string, "#microsoft.graph.publicError")
      code       = optional(string)
      details = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.publicErrorDetail")
        code       = optional(string)
        message    = optional(string)
        target     = optional(string)
      })))
      innerError = optional(object({
        odata_type = optional(string, "#microsoft.graph.publicInnerError")
        code       = optional(string)
        details    = optional(any)
        message    = optional(string)
        target     = optional(string)
      }))
      message = optional(string)
      target  = optional(string)
    }))
    stage  = optional(string)
    status = optional(string)
  }))
  default = null
}

variable "status" {
  description = "The status of the request. The possible values are: active, closed, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["active", "closed", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "team" {
  description = "Information about the Microsoft Teams team that was created for the request."
  type        = any
  default     = null
}

variable "type" {
  description = "The type of the request. The possible values are: export, delete, access, tagForAction, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.type == null ? true : contains(["export", "delete", "access", "tagForAction", "unknownFutureValue"], var.type)
    error_message = "type must be one of the documented enum values."
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
