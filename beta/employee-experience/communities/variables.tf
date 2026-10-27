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
      cloudLicensing = optional(object({
        odata_type     = optional(string, "#microsoft.graph.cloudLicensing.deviceCloudLicensing")
        assignments    = optional(any)
        usageRights    = optional(any)
        waitingMembers = optional(any)
      }))
      commands              = optional(any)
      deletedDateTime       = optional(string)
      deviceCategory        = optional(string)
      deviceId              = optional(string)
      deviceMetadata        = optional(string)
      deviceOwnership       = optional(string)
      deviceVersion         = optional(number)
      displayName           = optional(string)
      domainName            = optional(string)
      enrollmentProfileName = optional(string)
      enrollmentType        = optional(string)
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

  validation {
    condition     = (var.owners == null ? true : alltrue([alltrue([for input0 in var.owners : (input0 == null ? true : alltrue([(input0["chats"] == null ? true : alltrue([alltrue([for input2 in input0["chats"] : (input2 == null ? true : alltrue([(input2["chatType"] == null ? true : alltrue([(input2["chatType"] == null ? true : contains(["oneOnOne", "group", "meeting"], input2["chatType"]))])), (input2["migrationMode"] == null ? true : alltrue([(input2["migrationMode"] == null ? true : contains(["inProgress", "completed"], input2["migrationMode"]))]))]))])])), (input0["followedSites"] == null ? true : alltrue([alltrue([for input2 in input0["followedSites"] : (input2 == null ? true : alltrue([(input2["lockState"] == null ? true : alltrue([(input2["lockState"] == null ? true : contains(["unlocked", "lockedReadOnly", "lockedNoAccess", "lockedNoAdditions"], input2["lockState"]))])), (input2["template"] == null ? true : alltrue([(input2["template"] == null ? true : contains(["sitepagepublishing", "sts"], input2["template"]))]))]))])])), (input0["joinedGroups"] == null ? true : alltrue([alltrue([for input2 in input0["joinedGroups"] : (input2 == null ? true : alltrue([(input2["accessType"] == null ? true : alltrue([(input2["accessType"] == null ? true : contains(["none", "private", "secret", "public"], input2["accessType"]))]))]))])])), (input0["mailboxSettings"] == null ? true : alltrue([(input0["mailboxSettings"]["automaticRepliesSetting"] == null ? true : alltrue([(input0["mailboxSettings"]["automaticRepliesSetting"]["externalAudience"] == null ? true : alltrue([(input0["mailboxSettings"]["automaticRepliesSetting"]["externalAudience"] == null ? true : contains(["none", "contactsOnly", "all"], input0["mailboxSettings"]["automaticRepliesSetting"]["externalAudience"]))])), (input0["mailboxSettings"]["automaticRepliesSetting"]["status"] == null ? true : alltrue([(input0["mailboxSettings"]["automaticRepliesSetting"]["status"] == null ? true : contains(["disabled", "alwaysEnabled", "scheduled"], input0["mailboxSettings"]["automaticRepliesSetting"]["status"]))]))])), (input0["mailboxSettings"]["delegateMeetingMessageDeliveryOptions"] == null ? true : alltrue([(input0["mailboxSettings"]["delegateMeetingMessageDeliveryOptions"] == null ? true : contains(["sendToDelegateAndInformationToPrincipal", "sendToDelegateAndPrincipal", "sendToDelegateOnly"], input0["mailboxSettings"]["delegateMeetingMessageDeliveryOptions"]))])), (input0["mailboxSettings"]["userPurposeV2"] == null ? true : alltrue([(input0["mailboxSettings"]["userPurposeV2"] == null ? true : contains(["unknown", "user", "linked", "shared", "room", "equipment", "others"], input0["mailboxSettings"]["userPurposeV2"]))])), (input0["mailboxSettings"]["workingHours"] == null ? true : alltrue([(input0["mailboxSettings"]["workingHours"]["daysOfWeek"] == null ? true : alltrue([alltrue([for input4 in input0["mailboxSettings"]["workingHours"]["daysOfWeek"] : (input4 == null ? true : alltrue([(input4 == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input4))]))])]))]))])), (input0["managedAppLogCollectionRequests"] == null ? true : alltrue([alltrue([for input2 in input0["managedAppLogCollectionRequests"] : (input2 == null ? true : alltrue([(input2["userLogUploadConsent"] == null ? true : alltrue([(input2["userLogUploadConsent"] == null ? true : contains(["unknown", "declined", "accepted"], input2["userLogUploadConsent"]))]))]))])])), (input0["managedDevices"] == null ? true : alltrue([alltrue([for input2 in input0["managedDevices"] : (input2 == null ? true : alltrue([(input2["configurationManagerClientHealthState"] == null ? true : alltrue([(input2["configurationManagerClientHealthState"]["state"] == null ? true : alltrue([(input2["configurationManagerClientHealthState"]["state"] == null ? true : contains(["unknown", "installed", "healthy", "installFailed", "updateFailed", "communicationError"], input2["configurationManagerClientHealthState"]["state"]))]))])), (input2["joinType"] == null ? true : alltrue([(input2["joinType"] == null ? true : contains(["unknown", "azureADJoined", "azureADRegistered", "hybridAzureADJoined"], input2["joinType"]))])), (input2["managedDeviceOwnerType"] == null ? true : alltrue([(input2["managedDeviceOwnerType"] == null ? true : contains(["unknown", "company", "personal"], input2["managedDeviceOwnerType"]))])), (input2["managementFeatures"] == null ? true : alltrue([(input2["managementFeatures"] == null ? true : contains(["none", "microsoftManagedDesktop"], input2["managementFeatures"]))])), (input2["ownerType"] == null ? true : alltrue([(input2["ownerType"] == null ? true : contains(["unknown", "company", "personal"], input2["ownerType"]))]))]))])])), (input0["notifications"] == null ? true : alltrue([alltrue([for input2 in input0["notifications"] : (input2 == null ? true : alltrue([(input2["priority"] == null ? true : alltrue([(input2["priority"] == null ? true : contains(["None", "High", "Low"], input2["priority"]))]))]))])])), (input0["onlineMeetings"] == null ? true : alltrue([alltrue([for input2 in input0["onlineMeetings"] : (input2 == null ? true : alltrue([(input2["allowLiveShare"] == null ? true : alltrue([(input2["allowLiveShare"] == null ? true : contains(["enabled", "disabled"], input2["allowLiveShare"]))])), (input2["allowMeetingChat"] == null ? true : alltrue([(input2["allowMeetingChat"] == null ? true : contains(["enabled", "disabled", "limited"], input2["allowMeetingChat"]))])), (input2["allowedLobbyAdmitters"] == null ? true : alltrue([(input2["allowedLobbyAdmitters"] == null ? true : contains(["organizerAndCoOrganizersAndPresenters", "organizerAndCoOrganizers"], input2["allowedLobbyAdmitters"]))])), (input2["allowedPresenters"] == null ? true : alltrue([(input2["allowedPresenters"] == null ? true : contains(["everyone", "organization", "roleIsPresenter", "organizer"], input2["allowedPresenters"]))])), (input2["anonymizeIdentityForRoles"] == null ? true : alltrue([alltrue([for input4 in input2["anonymizeIdentityForRoles"] : (input4 == null ? true : alltrue([(input4 == null ? true : contains(["attendee", "presenter", "producer"], input4))]))])])), (input2["broadcastSettings"] == null ? true : alltrue([(input2["broadcastSettings"]["allowedAudience"] == null ? true : alltrue([(input2["broadcastSettings"]["allowedAudience"] == null ? true : contains(["roleIsAttendee", "organization", "everyone"], input2["broadcastSettings"]["allowedAudience"]))]))])), (input2["capabilities"] == null ? true : alltrue([alltrue([for input4 in input2["capabilities"] : (input4 == null ? true : alltrue([(input4 == null ? true : contains(["questionAndAnswer"], input4))]))])])), (input2["lobbyBypassSettings"] == null ? true : alltrue([(input2["lobbyBypassSettings"]["scope"] == null ? true : alltrue([(input2["lobbyBypassSettings"]["scope"] == null ? true : contains(["organizer", "organization", "organizationAndFederated", "everyone"], input2["lobbyBypassSettings"]["scope"]))]))])), (input2["shareMeetingChatHistoryDefault"] == null ? true : alltrue([(input2["shareMeetingChatHistoryDefault"] == null ? true : contains(["none", "all"], input2["shareMeetingChatHistoryDefault"]))]))]))])])), (input0["usageRights"] == null ? true : alltrue([alltrue([for input2 in input0["usageRights"] : (input2 == null ? true : alltrue([(input2["state"] == null ? true : alltrue([(input2["state"] == null ? true : contains(["active", "inactive", "warning", "suspended"], input2["state"]))]))]))])]))]))])]))
    error_message = "owners: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "privacy" {
  description = "Types of communityPrivacy."
  type        = string
  default     = null

  validation {
    condition     = var.privacy == null ? true : contains(["public", "private"], var.privacy)
    error_message = "privacy must be one of the documented enum values."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["groupId", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
