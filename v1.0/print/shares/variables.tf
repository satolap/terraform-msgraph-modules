variable "allowAllUsers" {
  description = "If true, all users and groups will be granted access to this printer share. This supersedes the allow lists defined by the allowedUsers and allowedGroups navigation properties."
  type        = bool
  default     = null
}

variable "allowedGroups" {
  description = "The groups whose users have access to print using the printer."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.group")
    acceptedSenders      = optional(any)
    accessType           = optional(string)
    allowExternalSenders = optional(bool)
    appRoleAssignments = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.appRoleAssignment")
      appRoleId           = optional(string)
      deletedDateTime     = optional(string)
      principalId         = optional(string)
      resourceDisplayName = optional(string)
      resourceId          = optional(string)
    })))
    assignedLabels = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.assignedLabel")
      labelId    = optional(string)
    })))
    autoSubscribeNewMembers = optional(bool)
    classification          = optional(string)
    conversations = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.conversation")
      hasAttachments        = optional(bool)
      lastDeliveredDateTime = optional(string)
      preview               = optional(string)
      topic                 = optional(string)
      uniqueSenders         = optional(list(string))
    })))
    deletedDateTime = optional(string)
    description     = optional(string)
    displayName     = optional(string)
    events = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.event")
      allowNewTimeProposals = optional(bool)
      attendees             = optional(any)
      body = optional(object({
        odata_type  = optional(string, "#microsoft.graph.itemBody")
        content     = optional(string)
        contentType = optional(string)
      }))
      bodyPreview          = optional(string)
      cancelledOccurrences = optional(list(string))
      categories           = optional(list(string))
      createdDateTime      = optional(string)
      end = optional(object({
        odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
        dateTime   = optional(string)
        timeZone   = optional(string)
      }))
      exceptionOccurrences  = optional(any)
      extensions            = optional(any)
      hasAttachments        = optional(bool)
      hideAttendees         = optional(bool)
      importance            = optional(string)
      isAllDay              = optional(bool)
      isCancelled           = optional(bool)
      isDraft               = optional(bool)
      isOnlineMeeting       = optional(bool)
      isOrganizer           = optional(bool)
      isReminderOn          = optional(bool)
      lastModifiedDateTime  = optional(string)
      location              = optional(any)
      locations             = optional(any)
      onlineMeetingProvider = optional(string)
      organizer             = optional(any)
      originalEndTimeZone   = optional(string)
      originalStart         = optional(string)
      originalStartTimeZone = optional(string)
      recurrence = optional(object({
        odata_type = optional(string, "#microsoft.graph.patternedRecurrence")
        pattern    = optional(any)
        range      = optional(any)
      }))
      reminderMinutesBeforeStart = optional(number)
      responseRequested          = optional(bool)
      responseStatus = optional(object({
        odata_type = optional(string, "#microsoft.graph.responseStatus")
        response   = optional(string)
        time       = optional(string)
      }))
      sensitivity    = optional(string)
      seriesMasterId = optional(string)
      showAs         = optional(string)
      start = optional(object({
        odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
        dateTime   = optional(string)
        timeZone   = optional(string)
      }))
      subject       = optional(string)
      transactionId = optional(string)
      webLink       = optional(string)
    })))
    groupTypes                    = optional(list(string))
    hasMembersWithLicenseErrors   = optional(bool)
    hideFromAddressLists          = optional(bool)
    hideFromOutlookClients        = optional(bool)
    infoCatalogs                  = optional(list(string))
    isAssignableToRole            = optional(bool)
    isFavorite                    = optional(bool)
    isSubscribedByMail            = optional(bool)
    mailEnabled                   = optional(bool)
    mailNickname                  = optional(string)
    members                       = optional(any)
    membershipRule                = optional(string)
    membershipRuleProcessingState = optional(string)
    onPremisesExtensionAttributes = optional(object({
      odata_type           = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")
      extensionAttribute1  = optional(string)
      extensionAttribute10 = optional(string)
      extensionAttribute11 = optional(string)
      extensionAttribute12 = optional(string)
      extensionAttribute13 = optional(string)
      extensionAttribute14 = optional(string)
      extensionAttribute15 = optional(string)
      extensionAttribute2  = optional(string)
      extensionAttribute3  = optional(string)
      extensionAttribute4  = optional(string)
      extensionAttribute5  = optional(string)
      extensionAttribute6  = optional(string)
      extensionAttribute7  = optional(string)
      extensionAttribute8  = optional(string)
      extensionAttribute9  = optional(string)
    }))
    onPremisesProvisioningErrors = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.onPremisesProvisioningError")
      category             = optional(string)
      occurredDateTime     = optional(string)
      propertyCausingError = optional(string)
      value                = optional(string)
    })))
    onPremisesSyncBehavior = optional(any)
    onenote                = optional(any)
    organizationId         = optional(string)
    owners                 = optional(any)
    permissionGrants = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
      deletedDateTime = optional(string)
    })))
    photo                       = optional(any)
    planner                     = optional(any)
    preferredDataLocation       = optional(string)
    preferredLanguage           = optional(string)
    rejectedSenders             = optional(any)
    resourceBehaviorOptions     = optional(list(string))
    resourceProvisioningOptions = optional(list(string))
    securityEnabled             = optional(bool)
    serviceProvisioningErrors   = optional(any)
    settings = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.groupSetting")
      displayName = optional(string)
      values      = optional(any)
    })))
    sites = optional(list(object({
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
    team  = optional(any)
    theme = optional(string)
    threads = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.conversationThread")
      ccRecipients          = optional(any)
      hasAttachments        = optional(bool)
      isLocked              = optional(bool)
      lastDeliveredDateTime = optional(string)
      posts                 = optional(any)
      preview               = optional(string)
      toRecipients          = optional(any)
      topic                 = optional(string)
      uniqueSenders         = optional(list(string))
    })))
    transitiveMemberOf       = optional(any)
    transitiveMembers        = optional(any)
    unseenConversationsCount = optional(number)
    unseenCount              = optional(number)
    unseenMessagesCount      = optional(number)
    visibility               = optional(string)
    welcomeMessageEnabled    = optional(bool)
  }))
  default = null

  validation {
    condition     = (var.allowedGroups == null ? true : alltrue([alltrue([for input0 in var.allowedGroups : (input0 == null ? true : alltrue([(input0["accessType"] == null ? true : alltrue([(input0["accessType"] == null ? true : contains(["none", "private", "secret", "public"], input0["accessType"]))])), (input0["events"] == null ? true : alltrue([alltrue([for input2 in input0["events"] : (input2 == null ? true : alltrue([(input2["body"] == null ? true : alltrue([(input2["body"]["contentType"] == null ? true : alltrue([(input2["body"]["contentType"] == null ? true : contains(["text", "html"], input2["body"]["contentType"]))]))])), (input2["importance"] == null ? true : alltrue([(input2["importance"] == null ? true : contains(["low", "normal", "high"], input2["importance"]))])), (input2["onlineMeetingProvider"] == null ? true : alltrue([(input2["onlineMeetingProvider"] == null ? true : contains(["unknown", "skypeForBusiness", "skypeForConsumer", "teamsForBusiness"], input2["onlineMeetingProvider"]))])), (input2["responseStatus"] == null ? true : alltrue([(input2["responseStatus"]["response"] == null ? true : alltrue([(input2["responseStatus"]["response"] == null ? true : contains(["none", "organizer", "tentativelyAccepted", "accepted", "declined", "notResponded"], input2["responseStatus"]["response"]))]))])), (input2["sensitivity"] == null ? true : alltrue([(input2["sensitivity"] == null ? true : contains(["normal", "personal", "private", "confidential"], input2["sensitivity"]))])), (input2["showAs"] == null ? true : alltrue([(input2["showAs"] == null ? true : contains(["unknown", "free", "tentative", "busy", "oof", "workingElsewhere"], input2["showAs"]))]))]))])]))]))])]))
    error_message = "allowedGroups: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "allowedUsers" {
  description = "The users who have access to print using the printer."
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
    condition     = (var.allowedUsers == null ? true : alltrue([for item0 in var.allowedUsers : (item0 == null ? true : alltrue([(item0["managedAppRegistrations"] == null ? true : alltrue([for item2 in item0["managedAppRegistrations"] : (item2 == null ? true : alltrue([(item2["odata_type"] == null ? false : contains(["#microsoft.graph.androidManagedAppRegistration", "#microsoft.graph.iosManagedAppRegistration"], item2["odata_type"]))]))]))]))]))
    error_message = "allowedUsers: every nested odata_type of an abstract Graph type must name a concrete type."
  }

  validation {
    condition     = (var.allowedUsers == null ? true : alltrue([alltrue([for input0 in var.allowedUsers : (input0 == null ? true : alltrue([(input0["chats"] == null ? true : alltrue([alltrue([for input2 in input0["chats"] : (input2 == null ? true : alltrue([(input2["chatType"] == null ? true : alltrue([(input2["chatType"] == null ? true : contains(["oneOnOne", "group", "meeting"], input2["chatType"]))])), (input2["migrationMode"] == null ? true : alltrue([(input2["migrationMode"] == null ? true : contains(["inProgress", "completed"], input2["migrationMode"]))]))]))])])), (input0["joinedTeams"] == null ? true : alltrue([alltrue([for input2 in input0["joinedTeams"] : (input2 == null ? true : alltrue([(input2["funSettings"] == null ? true : alltrue([(input2["funSettings"]["giphyContentRating"] == null ? true : alltrue([(input2["funSettings"]["giphyContentRating"] == null ? true : contains(["strict", "moderate"], input2["funSettings"]["giphyContentRating"]))]))])), (input2["specialization"] == null ? true : alltrue([(input2["specialization"] == null ? true : contains(["none", "educationStandard", "educationClass", "educationProfessionalLearningCommunity", "educationStaff", "healthcareStandard", "healthcareCareCoordination"], input2["specialization"]))])), (input2["visibility"] == null ? true : alltrue([(input2["visibility"] == null ? true : contains(["private", "public", "hiddenMembership"], input2["visibility"]))]))]))])])), (input0["mailboxSettings"] == null ? true : alltrue([(input0["mailboxSettings"]["automaticRepliesSetting"] == null ? true : alltrue([(input0["mailboxSettings"]["automaticRepliesSetting"]["externalAudience"] == null ? true : alltrue([(input0["mailboxSettings"]["automaticRepliesSetting"]["externalAudience"] == null ? true : contains(["none", "contactsOnly", "all"], input0["mailboxSettings"]["automaticRepliesSetting"]["externalAudience"]))])), (input0["mailboxSettings"]["automaticRepliesSetting"]["status"] == null ? true : alltrue([(input0["mailboxSettings"]["automaticRepliesSetting"]["status"] == null ? true : contains(["disabled", "alwaysEnabled", "scheduled"], input0["mailboxSettings"]["automaticRepliesSetting"]["status"]))]))])), (input0["mailboxSettings"]["delegateMeetingMessageDeliveryOptions"] == null ? true : alltrue([(input0["mailboxSettings"]["delegateMeetingMessageDeliveryOptions"] == null ? true : contains(["sendToDelegateAndInformationToPrincipal", "sendToDelegateAndPrincipal", "sendToDelegateOnly"], input0["mailboxSettings"]["delegateMeetingMessageDeliveryOptions"]))])), (input0["mailboxSettings"]["workingHours"] == null ? true : alltrue([(input0["mailboxSettings"]["workingHours"]["daysOfWeek"] == null ? true : alltrue([alltrue([for input4 in input0["mailboxSettings"]["workingHours"]["daysOfWeek"] : (input4 == null ? true : alltrue([(input4 == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input4))]))])]))]))])), (input0["managedAppRegistrations"] == null ? true : alltrue([alltrue([for input2 in input0["managedAppRegistrations"] : (input2 == null ? true : alltrue([(input2["odata_type"] == null ? true : alltrue([(input2["odata_type"] == null ? true : contains(["#microsoft.graph.androidManagedAppRegistration", "#microsoft.graph.iosManagedAppRegistration"], input2["odata_type"]))])), (input2["flaggedReasons"] == null ? true : alltrue([alltrue([for input4 in input2["flaggedReasons"] : (input4 == null ? true : alltrue([(input4 == null ? true : contains(["none", "rootedDevice"], input4))]))])]))]))])])), (input0["managedDevices"] == null ? true : alltrue([alltrue([for input2 in input0["managedDevices"] : (input2 == null ? true : alltrue([(input2["managedDeviceOwnerType"] == null ? true : alltrue([(input2["managedDeviceOwnerType"] == null ? true : contains(["unknown", "company", "personal"], input2["managedDeviceOwnerType"]))]))]))])])), (input0["onlineMeetings"] == null ? true : alltrue([alltrue([for input2 in input0["onlineMeetings"] : (input2 == null ? true : alltrue([(input2["allowLiveShare"] == null ? true : alltrue([(input2["allowLiveShare"] == null ? true : contains(["enabled", "disabled"], input2["allowLiveShare"]))])), (input2["allowMeetingChat"] == null ? true : alltrue([(input2["allowMeetingChat"] == null ? true : contains(["enabled", "disabled", "limited"], input2["allowMeetingChat"]))])), (input2["allowedLobbyAdmitters"] == null ? true : alltrue([(input2["allowedLobbyAdmitters"] == null ? true : contains(["organizerAndCoOrganizersAndPresenters", "organizerAndCoOrganizers"], input2["allowedLobbyAdmitters"]))])), (input2["allowedPresenters"] == null ? true : alltrue([(input2["allowedPresenters"] == null ? true : contains(["everyone", "organization", "roleIsPresenter", "organizer"], input2["allowedPresenters"]))])), (input2["broadcastSettings"] == null ? true : alltrue([(input2["broadcastSettings"]["allowedAudience"] == null ? true : alltrue([(input2["broadcastSettings"]["allowedAudience"] == null ? true : contains(["roleIsAttendee", "organization", "everyone"], input2["broadcastSettings"]["allowedAudience"]))]))])), (input2["lobbyBypassSettings"] == null ? true : alltrue([(input2["lobbyBypassSettings"]["scope"] == null ? true : alltrue([(input2["lobbyBypassSettings"]["scope"] == null ? true : contains(["organizer", "organization", "organizationAndFederated", "everyone"], input2["lobbyBypassSettings"]["scope"]))]))])), (input2["shareMeetingChatHistoryDefault"] == null ? true : alltrue([(input2["shareMeetingChatHistoryDefault"] == null ? true : contains(["none", "all"], input2["shareMeetingChatHistoryDefault"]))]))]))])]))]))])]))
    error_message = "allowedUsers: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "capabilities" {
  description = "The capabilities of the printer/printerShare."
  type = object({
    odata_type    = optional(string, "#microsoft.graph.printerCapabilities")
    bottomMargins = optional(list(number))
    collation     = optional(bool)
    colorModes    = optional(list(string))
    contentTypes  = optional(list(string))
    copiesPerJob = optional(object({
      odata_type = optional(string, "#microsoft.graph.integerRange")
      end        = optional(number)
      start      = optional(number)
    }))
    dpis                 = optional(list(number))
    duplexModes          = optional(list(string))
    feedOrientations     = optional(list(string))
    finishings           = optional(list(string))
    inputBins            = optional(list(string))
    isPageRangeSupported = optional(bool)
    leftMargins          = optional(list(number))
    mediaColors          = optional(list(string))
    mediaSizes           = optional(list(string))
    mediaTypes           = optional(list(string))
    multipageLayouts     = optional(list(string))
    orientations         = optional(list(string))
    outputBins           = optional(list(string))
    pagesPerSheet        = optional(list(number))
    qualities            = optional(list(string))
    rightMargins         = optional(list(number))
    scalings             = optional(list(string))
    supportsFitPdfToPage = optional(bool)
    topMargins           = optional(list(number))
  })
  default = null

  validation {
    condition     = (var.capabilities == null ? true : alltrue([(var.capabilities["colorModes"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["colorModes"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["blackAndWhite", "grayscale", "color", "auto"], input1))]))])])), (var.capabilities["duplexModes"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["duplexModes"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["flipOnLongEdge", "flipOnShortEdge", "oneSided"], input1))]))])])), (var.capabilities["feedOrientations"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["feedOrientations"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["longEdgeFirst", "shortEdgeFirst"], input1))]))])])), (var.capabilities["finishings"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["finishings"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["none", "staple", "punch", "cover", "bind", "saddleStitch", "stitchEdge", "stapleTopLeft", "stapleBottomLeft", "stapleTopRight", "stapleBottomRight", "stitchLeftEdge", "stitchTopEdge", "stitchRightEdge", "stitchBottomEdge", "stapleDualLeft", "stapleDualTop", "stapleDualRight", "stapleDualBottom"], input1))]))])])), (var.capabilities["multipageLayouts"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["multipageLayouts"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["clockwiseFromTopLeft", "counterclockwiseFromTopLeft", "counterclockwiseFromTopRight", "clockwiseFromTopRight", "counterclockwiseFromBottomLeft", "clockwiseFromBottomLeft", "counterclockwiseFromBottomRight", "clockwiseFromBottomRight"], input1))]))])])), (var.capabilities["orientations"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["orientations"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["portrait", "landscape", "reverseLandscape", "reversePortrait"], input1))]))])])), (var.capabilities["qualities"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["qualities"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["low", "medium", "high"], input1))]))])])), (var.capabilities["scalings"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["scalings"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["auto", "shrinkToFit", "fill", "fit", "none"], input1))]))])]))]))
    error_message = "capabilities: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "defaults" {
  description = "The default print settings of printer/printerShare."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.printerDefaults")
    colorMode       = optional(string)
    contentType     = optional(string)
    copiesPerJob    = optional(number)
    dpi             = optional(number)
    duplexMode      = optional(string)
    finishings      = optional(list(string))
    fitPdfToPage    = optional(bool)
    inputBin        = optional(string)
    mediaColor      = optional(string)
    mediaSize       = optional(string)
    mediaType       = optional(string)
    multipageLayout = optional(string)
    orientation     = optional(string)
    outputBin       = optional(string)
    pagesPerSheet   = optional(number)
    quality         = optional(string)
    scaling         = optional(string)
  })
  default = null

  validation {
    condition     = (var.defaults == null ? true : alltrue([(var.defaults["colorMode"] == null ? true : alltrue([(var.defaults["colorMode"] == null ? true : contains(["blackAndWhite", "grayscale", "color", "auto"], var.defaults["colorMode"]))])), (var.defaults["duplexMode"] == null ? true : alltrue([(var.defaults["duplexMode"] == null ? true : contains(["flipOnLongEdge", "flipOnShortEdge", "oneSided"], var.defaults["duplexMode"]))])), (var.defaults["finishings"] == null ? true : alltrue([alltrue([for input1 in var.defaults["finishings"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["none", "staple", "punch", "cover", "bind", "saddleStitch", "stitchEdge", "stapleTopLeft", "stapleBottomLeft", "stapleTopRight", "stapleBottomRight", "stitchLeftEdge", "stitchTopEdge", "stitchRightEdge", "stitchBottomEdge", "stapleDualLeft", "stapleDualTop", "stapleDualRight", "stapleDualBottom"], input1))]))])])), (var.defaults["multipageLayout"] == null ? true : alltrue([(var.defaults["multipageLayout"] == null ? true : contains(["clockwiseFromTopLeft", "counterclockwiseFromTopLeft", "counterclockwiseFromTopRight", "clockwiseFromTopRight", "counterclockwiseFromBottomLeft", "clockwiseFromBottomLeft", "counterclockwiseFromBottomRight", "clockwiseFromBottomRight"], var.defaults["multipageLayout"]))])), (var.defaults["orientation"] == null ? true : alltrue([(var.defaults["orientation"] == null ? true : contains(["portrait", "landscape", "reverseLandscape", "reversePortrait"], var.defaults["orientation"]))])), (var.defaults["quality"] == null ? true : alltrue([(var.defaults["quality"] == null ? true : contains(["low", "medium", "high"], var.defaults["quality"]))])), (var.defaults["scaling"] == null ? true : alltrue([(var.defaults["scaling"] == null ? true : contains(["auto", "shrinkToFit", "fill", "fit", "none"], var.defaults["scaling"]))]))]))
    error_message = "defaults: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "displayName" {
  description = "The name of the printer/printerShare."
  type        = string
  default     = null
}

variable "isAcceptingJobs" {
  description = "Specifies whether the printer/printerShare is currently accepting new print jobs."
  type        = bool
  default     = null
}

variable "jobs" {
  description = "The list of jobs that are queued for printing by the printer/printerShare."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.printJob")
    configuration = optional(object({
      odata_type   = optional(string, "#microsoft.graph.printJobConfiguration")
      collate      = optional(bool)
      finishings   = optional(list(string))
      fitPdfToPage = optional(bool)
      inputBin     = optional(string)
      margin = optional(object({
        odata_type = optional(string, "#microsoft.graph.printMargin")
        bottom     = optional(number)
        left       = optional(number)
        right      = optional(number)
        top        = optional(number)
      }))
      mediaSize       = optional(string)
      mediaType       = optional(string)
      multipageLayout = optional(string)
      orientation     = optional(string)
      outputBin       = optional(string)
      pagesPerSheet   = optional(number)
      scaling         = optional(string)
    }))
    createdBy = optional(object({
      odata_type        = optional(string, "#microsoft.graph.userIdentity")
      displayName       = optional(string)
      id                = optional(string)
      ipAddress         = optional(string)
      userPrincipalName = optional(string)
    }))
    documents = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.printDocument")
    })))
    isFetchable    = optional(bool)
    redirectedFrom = optional(string)
    redirectedTo   = optional(string)
    status = optional(object({
      odata_type = optional(string, "#microsoft.graph.printJobStatus")
      state      = optional(string)
    }))
    tasks = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.printTask")
      definition = optional(object({
        odata_type  = optional(string, "#microsoft.graph.printTaskDefinition")
        createdBy   = optional(any)
        displayName = optional(string)
      }))
      status = optional(object({
        odata_type  = optional(string, "#microsoft.graph.printTaskStatus")
        description = optional(string)
        state       = optional(string)
      }))
      trigger = optional(object({
        odata_type = optional(string, "#microsoft.graph.printTaskTrigger")
        definition = optional(any)
        event      = optional(string)
      }))
    })))
  }))
  default = null

  validation {
    condition     = (var.jobs == null ? true : alltrue([alltrue([for input0 in var.jobs : (input0 == null ? true : alltrue([(input0["configuration"] == null ? true : alltrue([(input0["configuration"]["finishings"] == null ? true : alltrue([alltrue([for input3 in input0["configuration"]["finishings"] : (input3 == null ? true : alltrue([(input3 == null ? true : contains(["none", "staple", "punch", "cover", "bind", "saddleStitch", "stitchEdge", "stapleTopLeft", "stapleBottomLeft", "stapleTopRight", "stapleBottomRight", "stitchLeftEdge", "stitchTopEdge", "stitchRightEdge", "stitchBottomEdge", "stapleDualLeft", "stapleDualTop", "stapleDualRight", "stapleDualBottom"], input3))]))])])), (input0["configuration"]["multipageLayout"] == null ? true : alltrue([(input0["configuration"]["multipageLayout"] == null ? true : contains(["clockwiseFromTopLeft", "counterclockwiseFromTopLeft", "counterclockwiseFromTopRight", "clockwiseFromTopRight", "counterclockwiseFromBottomLeft", "clockwiseFromBottomLeft", "counterclockwiseFromBottomRight", "clockwiseFromBottomRight"], input0["configuration"]["multipageLayout"]))])), (input0["configuration"]["orientation"] == null ? true : alltrue([(input0["configuration"]["orientation"] == null ? true : contains(["portrait", "landscape", "reverseLandscape", "reversePortrait"], input0["configuration"]["orientation"]))])), (input0["configuration"]["scaling"] == null ? true : alltrue([(input0["configuration"]["scaling"] == null ? true : contains(["auto", "shrinkToFit", "fill", "fit", "none"], input0["configuration"]["scaling"]))]))])), (input0["status"] == null ? true : alltrue([(input0["status"]["state"] == null ? true : alltrue([(input0["status"]["state"] == null ? true : contains(["unknown", "pending", "processing", "paused", "stopped", "completed", "canceled", "aborted"], input0["status"]["state"]))]))])), (input0["tasks"] == null ? true : alltrue([alltrue([for input2 in input0["tasks"] : (input2 == null ? true : alltrue([(input2["status"] == null ? true : alltrue([(input2["status"]["state"] == null ? true : alltrue([(input2["status"]["state"] == null ? true : contains(["pending", "processing", "completed", "aborted"], input2["status"]["state"]))]))])), (input2["trigger"] == null ? true : alltrue([(input2["trigger"]["event"] == null ? true : alltrue([(input2["trigger"]["event"] == null ? true : contains(["jobStarted"], input2["trigger"]["event"]))]))]))]))])]))]))])]))
    error_message = "jobs: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "location" {
  description = "The physical and/or organizational location of the printer/printerShare."
  type = object({
    odata_type       = optional(string, "#microsoft.graph.printerLocation")
    altitudeInMeters = optional(number)
    building         = optional(string)
    city             = optional(string)
    countryOrRegion  = optional(string)
    floor            = optional(string)
    floorDescription = optional(string)
    latitude         = optional(any)
    longitude        = optional(any)
    organization     = optional(list(string))
    postalCode       = optional(string)
    roomDescription  = optional(string)
    roomName         = optional(string)
    site             = optional(string)
    stateOrProvince  = optional(string)
    streetAddress    = optional(string)
    subdivision      = optional(list(string))
    subunit          = optional(list(string))
  })
  default = null
}

variable "manufacturer" {
  description = "The manufacturer of the printer/printerShare."
  type        = string
  default     = null
}

variable "model" {
  description = "The model name of the printer/printerShare."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.printerShare"
  nullable    = false
}

variable "printer" {
  description = "The printer that this printer share is related to."
  type        = any
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.printerStatus")
    state      = optional(string)
  })
  default = null

  validation {
    condition     = (var.status == null ? true : alltrue([(var.status["state"] == null ? true : alltrue([(var.status["state"] == null ? true : contains(["unknown", "idle", "processing", "stopped"], var.status["state"]))]))]))
    error_message = "status: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "viewPoint" {
  description = "Additional data for a printer share as viewed by the signed-in user."
  type = object({
    odata_type       = optional(string, "#microsoft.graph.printerShareViewpoint")
    lastUsedDateTime = optional(string)
  })
  default = null
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
