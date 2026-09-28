variable "all_channels" {
  description = "List of channels either hosted in or shared with the team (incoming channels)."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.channel")
    allMembers  = optional(any)
    description = optional(string)
    displayName = optional(string)
    enabledApps = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.teamsApp")
      appDefinitions = optional(any)
      displayName    = optional(string)
      externalId     = optional(string)
    })))
    filesFolder         = optional(any)
    isFavoriteByDefault = optional(bool)
    joinedUsers         = optional(any)
    layoutType          = optional(string)
    members             = optional(any)
    membershipType      = optional(string)
    messages            = optional(any)
    migrationMode       = optional(string)
    moderationSettings = optional(object({
      odata_type                    = optional(string, "#microsoft.graph.channelModerationSettings")
      allowNewMessageFromBots       = optional(bool)
      allowNewMessageFromConnectors = optional(bool)
      replyRestriction              = optional(string)
      userNewMessageRestriction     = optional(string)
    }))
    originalCreatedDateTime = optional(string)
    sharedWithTeams = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")
      allowedMembers = optional(any)
      displayName    = optional(string)
      isHostTeam     = optional(bool)
      team           = optional(any)
      tenantId       = optional(string)
    })))
    summary = optional(object({
      odata_type                 = optional(string, "#microsoft.graph.channelSummary")
      guestsCount                = optional(number)
      hasMembersFromOtherTenants = optional(bool)
      membersCount               = optional(number)
      ownersCount                = optional(number)
    }))
    tabs = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.teamsTab")
      configuration = optional(object({
        odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")
        contentUrl = optional(string)
        entityId   = optional(string)
        removeUrl  = optional(string)
        websiteUrl = optional(string)
      }))
      displayName    = optional(string)
      messageId      = optional(string)
      sortOrderIndex = optional(string)
      teamsApp       = optional(any)
      teamsAppId     = optional(string)
    })))
    tenantId = optional(string)
  }))
  default = null
}

variable "channels" {
  description = "The collection of channels and messages associated with the team."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.channel")
    allMembers  = optional(any)
    description = optional(string)
    displayName = optional(string)
    enabledApps = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.teamsApp")
      appDefinitions = optional(any)
      displayName    = optional(string)
      externalId     = optional(string)
    })))
    filesFolder         = optional(any)
    isFavoriteByDefault = optional(bool)
    joinedUsers         = optional(any)
    layoutType          = optional(string)
    members             = optional(any)
    membershipType      = optional(string)
    messages            = optional(any)
    migrationMode       = optional(string)
    moderationSettings = optional(object({
      odata_type                    = optional(string, "#microsoft.graph.channelModerationSettings")
      allowNewMessageFromBots       = optional(bool)
      allowNewMessageFromConnectors = optional(bool)
      replyRestriction              = optional(string)
      userNewMessageRestriction     = optional(string)
    }))
    originalCreatedDateTime = optional(string)
    sharedWithTeams = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")
      allowedMembers = optional(any)
      displayName    = optional(string)
      isHostTeam     = optional(bool)
      team           = optional(any)
      tenantId       = optional(string)
    })))
    summary = optional(object({
      odata_type                 = optional(string, "#microsoft.graph.channelSummary")
      guestsCount                = optional(number)
      hasMembersFromOtherTenants = optional(bool)
      membersCount               = optional(number)
      ownersCount                = optional(number)
    }))
    tabs = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.teamsTab")
      configuration = optional(object({
        odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")
        contentUrl = optional(string)
        entityId   = optional(string)
        removeUrl  = optional(string)
        websiteUrl = optional(string)
      }))
      displayName    = optional(string)
      messageId      = optional(string)
      sortOrderIndex = optional(string)
      teamsApp       = optional(any)
      teamsAppId     = optional(string)
    })))
    tenantId = optional(string)
  }))
  default = null
}

variable "classification" {
  description = "An optional label. Typically describes the data or business sensitivity of the team. Must match one of a pre-configured set in the tenant's directory."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Timestamp at which the team was created."
  type        = string
  default     = null
}

variable "description" {
  description = "An optional description for the team. Maximum length: 1,024 characters."
  type        = string
  default     = null
}

variable "discovery_settings" {
  description = "Settings to configure team discoverability by others."
  type = object({
    odata_type                      = optional(string, "#microsoft.graph.teamDiscoverySettings")
    showInTeamsSearchAndSuggestions = optional(bool)
  })
  default = null
}

variable "display_name" {
  description = "The name of the team."
  type        = string
  default     = null
}

variable "first_channel_name" {
  description = "The name of the first channel in the team. This is an optional property, only used during team creation and isn't returned in methods to get and list teams."
  type        = string
  default     = null
}

variable "fun_settings" {
  description = "Settings to configure the use of Giphy, memes, and stickers in the team."
  type = object({
    odata_type            = optional(string, "#microsoft.graph.teamFunSettings")
    allowCustomMemes      = optional(bool)
    allowGiphy            = optional(bool)
    allowStickersAndMemes = optional(bool)
    giphyContentRating    = optional(string)
  })
  default = null
}

variable "group" {
  description = "Microsoft Graph group property."
  type        = any
  default     = null
}

variable "guest_settings" {
  description = "Settings to configure whether guests can create, update, or delete channels in the team."
  type = object({
    odata_type                = optional(string, "#microsoft.graph.teamGuestSettings")
    allowCreateUpdateChannels = optional(bool)
    allowDeleteChannels       = optional(bool)
  })
  default = null
}

variable "incoming_channels" {
  description = "List of channels shared with the team."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.channel")
    allMembers  = optional(any)
    description = optional(string)
    displayName = optional(string)
    enabledApps = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.teamsApp")
      appDefinitions = optional(any)
      displayName    = optional(string)
      externalId     = optional(string)
    })))
    filesFolder         = optional(any)
    isFavoriteByDefault = optional(bool)
    joinedUsers         = optional(any)
    layoutType          = optional(string)
    members             = optional(any)
    membershipType      = optional(string)
    messages            = optional(any)
    migrationMode       = optional(string)
    moderationSettings = optional(object({
      odata_type                    = optional(string, "#microsoft.graph.channelModerationSettings")
      allowNewMessageFromBots       = optional(bool)
      allowNewMessageFromConnectors = optional(bool)
      replyRestriction              = optional(string)
      userNewMessageRestriction     = optional(string)
    }))
    originalCreatedDateTime = optional(string)
    sharedWithTeams = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")
      allowedMembers = optional(any)
      displayName    = optional(string)
      isHostTeam     = optional(bool)
      team           = optional(any)
      tenantId       = optional(string)
    })))
    summary = optional(object({
      odata_type                 = optional(string, "#microsoft.graph.channelSummary")
      guestsCount                = optional(number)
      hasMembersFromOtherTenants = optional(bool)
      membersCount               = optional(number)
      ownersCount                = optional(number)
    }))
    tabs = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.teamsTab")
      configuration = optional(object({
        odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")
        contentUrl = optional(string)
        entityId   = optional(string)
        removeUrl  = optional(string)
        websiteUrl = optional(string)
      }))
      displayName    = optional(string)
      messageId      = optional(string)
      sortOrderIndex = optional(string)
      teamsApp       = optional(any)
      teamsAppId     = optional(string)
    })))
    tenantId = optional(string)
  }))
  default = null
}

variable "installed_apps" {
  description = "The apps installed in this team."
  type        = any
  default     = null
}

variable "internal_id" {
  description = "A unique ID for the team used in a few places such as the audit log/Office 365 Management Activity API."
  type        = string
  default     = null
}

variable "is_membership_limited_to_owners" {
  description = "If set to true, the team is currently in the owner-only team membership state and inaccessible by other team members, such as students."
  type        = bool
  default     = null
}

variable "member_settings" {
  description = "Settings to configure whether members can perform certain actions, for example, create channels and add bots, in the team."
  type = object({
    odata_type                        = optional(string, "#microsoft.graph.teamMemberSettings")
    allowAddRemoveApps                = optional(bool)
    allowCreatePrivateChannels        = optional(bool)
    allowCreateUpdateChannels         = optional(bool)
    allowCreateUpdateRemoveConnectors = optional(bool)
    allowCreateUpdateRemoveTabs       = optional(bool)
    allowDeleteChannels               = optional(bool)
  })
  default = null
}

variable "members" {
  description = "Members and owners of the team."
  type        = any
  default     = null
}

variable "messaging_settings" {
  description = "Settings to configure messaging and mentions in the team."
  type = object({
    odata_type               = optional(string, "#microsoft.graph.teamMessagingSettings")
    allowChannelMentions     = optional(bool)
    allowOwnerDeleteMessages = optional(bool)
    allowTeamMentions        = optional(bool)
    allowUserDeleteMessages  = optional(bool)
    allowUserEditMessages    = optional(bool)
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.team"
  nullable    = false
}

variable "operations" {
  description = "The async operations that ran or are running on this team."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.teamsAsyncOperation")
    attemptsCount   = optional(number)
    createdDateTime = optional(string)
    error = optional(object({
      odata_type = optional(string, "#microsoft.graph.operationError")
      code       = optional(string)
      message    = optional(string)
    }))
    lastActionDateTime     = optional(string)
    operationType          = optional(string)
    status                 = optional(string)
    targetResourceId       = optional(string)
    targetResourceLocation = optional(string)
  }))
  default = null
}

variable "owners" {
  description = "The list of this team's owners. Currently, when creating a team using application permissions, exactly one owner must be specified. When using user-delegated permissions, no owner can be specified (the current user is the owner). The owner must be specified as an object ID (GUID), not a UPN."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.user")
    aboutMe        = optional(string)
    accountEnabled = optional(bool)
    ageGroup       = optional(string)
    analytics      = optional(any)
    appConsentRequestsForApproval = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.appConsentRequest")
      appDisplayName      = optional(string)
      appId               = optional(string)
      consentType         = optional(string)
      pendingScopes       = optional(any)
      userConsentRequests = optional(any)
    })))
    appRoleAssignedResources = optional(any)
    appRoleAssignments = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.appRoleAssignment")
      appRoleId           = optional(string)
      deletedDateTime     = optional(string)
      principalId         = optional(string)
      resourceDisplayName = optional(string)
      resourceId          = optional(string)
    })))
    approvals = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.approval")
      steps      = optional(any)
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
      operations              = optional(any)
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
    city           = optional(string)
    cloudClipboard = optional(any)
    cloudLicensing = optional(object({
      odata_type = optional(string, "#microsoft.graph.cloudLicensing.userCloudLicensing")
      assignmentErrors = optional(list(object({
        odata_type         = optional(string, "#microsoft.graph.cloudLicensing.assignmentError")
        assignedTo         = optional(any)
        code               = optional(string)
        message            = optional(string)
        occurrenceDateTime = optional(string)
      })))
      assignments = optional(list(object({
        odata_type             = optional(string, "#microsoft.graph.cloudLicensing.assignment")
        allotment              = optional(any)
        assignedTo             = optional(any)
        disabledServicePlanIds = optional(any)
      })))
      usageRights = optional(list(object({
        odata_type                = optional(string, "#microsoft.graph.cloudLicensing.usageRight")
        allotments                = optional(any)
        assignments               = optional(any)
        externalServiceIdentifier = optional(string)
      })))
      waitingMembers = optional(list(object({
        odata_type           = optional(string, "#microsoft.graph.cloudLicensing.waitingMember")
        allotment            = optional(any)
        assignedTo           = optional(any)
        waitingSinceDateTime = optional(string)
      })))
    }))
    cloudRealtimeCommunicationInfo = optional(object({
      odata_type = optional(string, "#microsoft.graph.cloudRealtimeCommunicationInfo")
    }))
    communications                 = optional(any)
    companyName                    = optional(string)
    consentProvidedForMinor        = optional(string)
    country                        = optional(string)
    customSecurityAttributes       = optional(any)
    deletedDateTime                = optional(string)
    department                     = optional(string)
    deviceEnrollmentConfigurations = optional(any)
    deviceEnrollmentLimit          = optional(number)
    deviceKeys = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.deviceKey")
      deviceId    = optional(string)
      keyMaterial = optional(string)
      keyType     = optional(string)
    })))
    deviceManagementTroubleshootingEvents = optional(any)
    devices = optional(list(object({
      odata_type             = optional(string, "#microsoft.graph.device")
      accountEnabled         = optional(bool)
      alternativeNames       = optional(list(string))
      alternativeSecurityIds = optional(any)
      commands               = optional(any)
      deletedDateTime        = optional(string)
      deviceCategory         = optional(string)
      deviceId               = optional(string)
      deviceMetadata         = optional(string)
      deviceOwnership        = optional(string)
      deviceVersion          = optional(number)
      displayName            = optional(string)
      domainName             = optional(string)
      enrollmentProfileName  = optional(string)
      enrollmentType         = optional(string)
      extensionAttributes = optional(object({
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
      hostnames              = optional(list(string))
      isManaged              = optional(bool)
      isRooted               = optional(bool)
      kind                   = optional(string)
      managementType         = optional(string)
      name                   = optional(string)
      operatingSystem        = optional(string)
      operatingSystemVersion = optional(string)
      physicalIds            = optional(list(string))
      platform               = optional(string)
      profileType            = optional(string)
      status                 = optional(string)
      systemLabels           = optional(list(string))
      transitiveMemberOf     = optional(any)
      usageRights            = optional(any)
    })))
    displayName           = optional(string)
    employeeHireDate      = optional(string)
    employeeId            = optional(string)
    employeeLeaveDateTime = optional(string)
    employeeOrgData = optional(object({
      odata_type = optional(string, "#microsoft.graph.employeeOrgData")
      costCenter = optional(string)
      division   = optional(string)
    }))
    employeeType                    = optional(string)
    extensions                      = optional(any)
    externalUserState               = optional(string)
    externalUserStateChangeDateTime = optional(string)
    faxNumber                       = optional(string)
    followedSites = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.site")
      analytics     = optional(any)
      columns       = optional(any)
      contentModels = optional(any)
      contentTypes  = optional(any)
      createdByUser = optional(any)
      deleted = optional(object({
        odata_type = optional(string, "#microsoft.graph.deleted")
        state      = optional(string)
      }))
      description            = optional(string)
      documentProcessingJobs = optional(any)
      drive                  = optional(any)
      drives                 = optional(any)
      extensions             = optional(any)
      externalColumns        = optional(any)
      informationProtection  = optional(any)
      isPersonalSite         = optional(bool)
      items                  = optional(any)
      lastModifiedByUser     = optional(any)
      lists                  = optional(any)
      locale                 = optional(string)
      lockState              = optional(string)
      name                   = optional(string)
      onenote                = optional(any)
      operations             = optional(any)
      ownerIdentityToResolve = optional(object({
        odata_type = optional(string, "#microsoft.graph.identityInput")
        alias      = optional(string)
        email      = optional(string)
        objectId   = optional(string)
      }))
      pageTemplates = optional(any)
      pages         = optional(any)
      parentReference = optional(object({
        odata_type = optional(string, "#microsoft.graph.itemReference")
        driveType  = optional(string)
        shareId    = optional(string)
        siteId     = optional(string)
      }))
      permissions         = optional(any)
      recycleBin          = optional(any)
      shareByEmailEnabled = optional(bool)
      sites               = optional(any)
      template            = optional(string)
      termStore           = optional(any)
    })))
    givenName = optional(string)
    hireDate  = optional(string)
    identities = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.objectIdentity")
      issuer           = optional(string)
      issuerAssignedId = optional(string)
      signInType       = optional(string)
    })))
    identityGovernance = optional(object({
      odata_type = optional(string, "#microsoft.graph.identityGovernanceUserSettings")
      approverDelegate = optional(object({
        odata_type = optional(string, "#microsoft.graph.approverDelegate")
        delegate   = optional(any)
        schedule = optional(object({
          odata_type    = optional(string, "#microsoft.graph.requestSchedule")
          expiration    = optional(any)
          recurrence    = optional(any)
          startDateTime = optional(string)
        }))
      }))
    }))
    identityParentId        = optional(string)
    inferenceClassification = optional(any)
    infoCatalogs            = optional(list(string))
    informationProtection   = optional(any)
    interests               = optional(list(string))
    invitedBy               = optional(any)
    isResourceAccount       = optional(bool)
    jobTitle                = optional(string)
    joinedGroups = optional(list(object({
      odata_type              = optional(string, "#microsoft.graph.group")
      acceptedSenders         = optional(any)
      accessType              = optional(string)
      allowExternalSenders    = optional(bool)
      appRoleAssignments      = optional(any)
      assignedLabels          = optional(any)
      autoSubscribeNewMembers = optional(bool)
      classification          = optional(string)
      cloudLicensing = optional(object({
        odata_type  = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")
        assignments = optional(any)
        usageRights = optional(any)
      }))
      conversations                 = optional(any)
      deletedDateTime               = optional(string)
      description                   = optional(string)
      displayName                   = optional(string)
      events                        = optional(any)
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
      onPremisesProvisioningErrors = optional(any)
      onPremisesSyncBehavior       = optional(any)
      onenote                      = optional(any)
      organizationId               = optional(string)
      owners                       = optional(any)
      permissionGrants             = optional(any)
      photo                        = optional(any)
      preferredDataLocation        = optional(string)
      preferredLanguage            = optional(string)
      rejectedSenders              = optional(any)
      resourceBehaviorOptions      = optional(list(string))
      resourceProvisioningOptions  = optional(list(string))
      securityEnabled              = optional(bool)
      serviceProvisioningErrors    = optional(any)
      settings                     = optional(any)
      sites                        = optional(any)
      team                         = optional(any)
      theme                        = optional(string)
      threads                      = optional(any)
      transitiveMemberOf           = optional(any)
      transitiveMembers            = optional(any)
      unseenConversationsCount     = optional(number)
      unseenCount                  = optional(number)
      unseenMessagesCount          = optional(number)
      visibility                   = optional(string)
      welcomeMessageEnabled        = optional(bool)
      writebackConfiguration = optional(object({
        odata_type          = optional(string, "#microsoft.graph.groupWritebackConfiguration")
        isEnabled           = optional(bool)
        onPremisesGroupType = optional(string)
      }))
    })))
    licenseDetails = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.licenseDetails")
    })))
    mail         = optional(string)
    mailNickname = optional(string)
    mailboxSettings = optional(object({
      odata_type = optional(string, "#microsoft.graph.mailboxSettings")
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
      timeFormat    = optional(string)
      timeZone      = optional(string)
      userPurposeV2 = optional(string)
      workingHours = optional(object({
        odata_type = optional(string, "#microsoft.graph.workingHours")
        daysOfWeek = optional(list(string))
        endTime    = optional(string)
        startTime  = optional(string)
        timeZone   = optional(any)
      }))
    }))
    managedAppLogCollectionRequests = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.managedAppLogCollectionRequest")
      userLogUploadConsent = optional(string)
      version              = optional(string)
    })))
    managedAppRegistrations = optional(any)
    managedDevices = optional(list(object({
      odata_type                              = optional(string, "#microsoft.graph.managedDevice")
      assignmentFilterEvaluationStatusDetails = optional(any)
      chromeOSDeviceInfo                      = optional(any)
      cloudPcRemoteActionResults              = optional(any)
      configurationManagerClientHealthState = optional(object({
        odata_type       = optional(string, "#microsoft.graph.configurationManagerClientHealthState")
        errorCode        = optional(number)
        lastSyncDateTime = optional(string)
        state            = optional(string)
      }))
      configurationManagerClientInformation = optional(object({
        odata_type       = optional(string, "#microsoft.graph.configurationManagerClientInformation")
        clientIdentifier = optional(string)
        clientVersion    = optional(string)
        isBlocked        = optional(bool)
      }))
      detectedApps                                = optional(any)
      deviceCategory                              = optional(any)
      deviceCompliancePolicyStates                = optional(any)
      deviceConfigurationStates                   = optional(any)
      deviceFirmwareConfigurationInterfaceManaged = optional(bool)
      joinType                                    = optional(string)
      logCollectionRequests                       = optional(any)
      managedDeviceMobileAppConfigurationStates   = optional(any)
      managedDeviceName                           = optional(string)
      managedDeviceOwnerType                      = optional(string)
      managementFeatures                          = optional(string)
      notes                                       = optional(string)
      ownerType                                   = optional(string)
      roleScopeTagIds                             = optional(list(string))
      securityBaselineStates                      = optional(any)
      skuFamily                                   = optional(string)
      users                                       = optional(any)
    })))
    mobileAppIntentAndStates = optional(list(object({
      odata_type              = optional(string, "#microsoft.graph.mobileAppIntentAndState")
      managedDeviceIdentifier = optional(string)
      mobileAppList           = optional(any)
      userId                  = optional(string)
    })))
    mobileAppTroubleshootingEvents = optional(list(object({
      odata_type               = optional(string, "#microsoft.graph.mobileAppTroubleshootingEvent")
      additionalInformation    = optional(any)
      appLogCollectionRequests = optional(any)
      applicationId            = optional(string)
      correlationId            = optional(string)
      deviceId                 = optional(string)
      eventDateTime            = optional(string)
      eventName                = optional(string)
      history                  = optional(any)
      managedDeviceIdentifier  = optional(string)
      troubleshootingErrorDetails = optional(object({
        odata_type     = optional(string, "#microsoft.graph.deviceManagementTroubleshootingErrorDetails")
        context        = optional(string)
        failure        = optional(string)
        failureDetails = optional(string)
        remediation    = optional(string)
        resources      = optional(any)
      }))
      userId = optional(string)
    })))
    mySite = optional(string)
    notifications = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.notification")
      displayTimeToLive  = optional(number)
      expirationDateTime = optional(string)
      groupName          = optional(string)
      payload = optional(object({
        odata_type    = optional(string, "#microsoft.graph.payloadTypes")
        rawContent    = optional(string)
        visualContent = optional(any)
      }))
      priority       = optional(string)
      targetHostName = optional(string)
      targetPolicy = optional(object({
        odata_type    = optional(string, "#microsoft.graph.targetPolicyEndpoints")
        platformTypes = optional(any)
      }))
    })))
    oauth2PermissionGrants = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.oAuth2PermissionGrant")
      clientId    = optional(string)
      consentType = optional(string)
      expiryTime  = optional(string)
      principalId = optional(string)
      resourceId  = optional(string)
      scope       = optional(string)
      startTime   = optional(string)
    })))
    officeLocation              = optional(string)
    onPremisesDistinguishedName = optional(string)
    onPremisesDomainName        = optional(string)
    onPremisesImmutableId       = optional(string)
    onPremisesProvisioningErrors = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.onPremisesProvisioningError")
      category             = optional(string)
      occurredDateTime     = optional(string)
      propertyCausingError = optional(string)
      value                = optional(string)
    })))
    onPremisesSamAccountName     = optional(string)
    onPremisesSecurityIdentifier = optional(string)
    onPremisesSyncBehavior       = optional(any)
    onPremisesUserPrincipalName  = optional(string)
    onenote                      = optional(any)
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
      anonymizeIdentityForRoles            = optional(list(string))
      broadcastRecording                   = optional(string)
      broadcastSettings = optional(object({
        odata_type                 = optional(string, "#microsoft.graph.broadcastMeetingSettings")
        allowedAudience            = optional(string)
        captions                   = optional(any)
        isAttendeeReportEnabled    = optional(bool)
        isQuestionAndAnswerEnabled = optional(bool)
        isRecordingEnabled         = optional(bool)
        isVideoOnDemandEnabled     = optional(bool)
      }))
      capabilities = optional(list(string))
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
      joinUrl = optional(string)
      lobbyBypassSettings = optional(object({
        odata_type            = optional(string, "#microsoft.graph.lobbyBypassSettings")
        isDialInBypassEnabled = optional(bool)
        scope                 = optional(string)
      }))
      meetingOptionsWebUrl     = optional(string)
      meetingSpokenLanguageTag = optional(string)
      meetingTemplateId        = optional(string)
      participants = optional(object({
        odata_type   = optional(string, "#microsoft.graph.meetingParticipants")
        attendees    = optional(any)
        contributors = optional(any)
        organizer    = optional(any)
        producers    = optional(any)
      }))
      recordAutomatically = optional(bool)
      registration        = optional(any)
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
    passwordPolicies = optional(string)
    passwordProfile = optional(object({
      odata_type                           = optional(string, "#microsoft.graph.passwordProfile")
      forceChangePasswordNextSignIn        = optional(bool)
      forceChangePasswordNextSignInWithMfa = optional(bool)
      password                             = optional(string)
    }))
    pastProjects = optional(list(string))
    pendingAccessReviewInstances = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.accessReviewInstance")
      decisions         = optional(any)
      definition        = optional(any)
      fallbackReviewers = optional(any)
      reviewers         = optional(any)
      stages            = optional(any)
    })))
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
        name            = optional(string)
        printer         = optional(any)
        status          = optional(any)
        viewPoint       = optional(any)
      })))
    }))
    profile                   = optional(any)
    responsibilities          = optional(list(string))
    schools                   = optional(list(string))
    security                  = optional(any)
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
    usageRights = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.usageRight")
      catalogId         = optional(string)
      serviceIdentifier = optional(string)
      state             = optional(string)
    })))
    userPrincipalName = optional(string)
    userType          = optional(string)
    virtualEvents     = optional(any)
    windowsInformationProtectionDeviceRegistrations = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.windowsInformationProtectionDeviceRegistration")
      deviceMacAddress     = optional(string)
      deviceName           = optional(string)
      deviceRegistrationId = optional(string)
      deviceType           = optional(string)
      lastCheckInDateTime  = optional(string)
      userId               = optional(string)
    })))
  }))
  default   = null
  sensitive = true
}

variable "permission_grants" {
  description = "A collection of permissions granted to apps to access the team."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "photo" {
  description = "The team photo."
  type        = any
  default     = null
}

variable "primary_channel" {
  description = "The general channel for the team."
  type        = any
  default     = null
}

variable "schedule" {
  description = "The schedule of shifts for this team."
  type        = any
  default     = null
}

variable "specialization" {
  description = "Optional. Indicates whether the team is intended for a particular use case.  Each team specialization has access to unique behaviors and experiences targeted to its use case."
  type        = string
  default     = null

  validation {
    condition     = var.specialization == null ? true : contains(["none", "educationStandard", "educationClass", "educationProfessionalLearningCommunity", "educationStaff", "healthcareStandard", "healthcareCareCoordination", "unknownFutureValue"], var.specialization)
    error_message = "specialization must be one of the documented enum values."
  }
}

variable "summary" {
  description = "Contains summary information about the team, including the number of owners, members, and guests."
  type = object({
    odata_type   = optional(string, "#microsoft.graph.teamSummary")
    guestsCount  = optional(number)
    membersCount = optional(number)
    ownersCount  = optional(number)
  })
  default = null
}

variable "tags" {
  description = "The tags associated with the team."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.teamworkTag")
    description = optional(string)
    displayName = optional(string)
    memberCount = optional(number)
    members = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.teamworkTagMember")
      displayName = optional(string)
      tenantId    = optional(string)
      userId      = optional(string)
    })))
    tagType = optional(string)
    teamId  = optional(string)
  }))
  default = null
}

variable "template" {
  description = "The template this team was created from. See available templates."
  type        = any
  default     = null
}

variable "template_definition" {
  description = "Generic representation of a team template definition for a team with a specific structure and configuration."
  type        = any
  default     = null
}

variable "tenant_id" {
  description = "The ID of the Microsoft Entra tenant."
  type        = string
  default     = null
}

variable "visibility" {
  description = "The visibility of the group and team. Defaults to Public."
  type        = string
  default     = null

  validation {
    condition     = var.visibility == null ? true : contains(["private", "public", "hiddenMembership", "unknownFutureValue"], var.visibility)
    error_message = "visibility must be one of the documented enum values."
  }
}

variable "web_url" {
  description = "A hyperlink that goes to the team in the Microsoft Teams client. It's the URL you get when you right-click a team in the Microsoft Teams client and select Get link to team. This URL should be treated as an opaque blob, and not parsed."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "isArchived"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
