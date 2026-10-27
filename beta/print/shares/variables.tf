variable "allow_all_users" {
  description = "If true, all users and groups can access this printer share. This property supersedes the lists of allowed users and groups defined by the allowedUsers and allowedGroups navigation properties."
  type        = bool
  default     = null
}

variable "allowed_groups" {
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
    cloudLicensing = optional(object({
      odata_type = optional(string, "#microsoft.graph.cloudLicensing.groupCloudLicensing")
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
    }))
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
      occurrenceId          = optional(string)
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
      uid           = optional(string)
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
    preferredDataLocation       = optional(string)
    preferredLanguage           = optional(string)
    rejectedSenders             = optional(any)
    resourceBehaviorOptions     = optional(list(string))
    resourceProvisioningOptions = optional(list(string))
    securityEnabled             = optional(bool)
    serviceProvisioningErrors   = optional(any)
    settings = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.directorySetting")
      values     = optional(any)
    })))
    sites = optional(list(object({
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
    writebackConfiguration = optional(object({
      odata_type          = optional(string, "#microsoft.graph.groupWritebackConfiguration")
      isEnabled           = optional(bool)
      onPremisesGroupType = optional(string)
    }))
  }))
  default = null

  validation {
    condition     = (var.allowed_groups == null ? true : alltrue([alltrue([for input0 in var.allowed_groups : (input0 == null ? true : alltrue([(input0["accessType"] == null ? true : alltrue([(input0["accessType"] == null ? true : contains(["none", "private", "secret", "public"], input0["accessType"]))])), (input0["events"] == null ? true : alltrue([alltrue([for input2 in input0["events"] : (input2 == null ? true : alltrue([(input2["body"] == null ? true : alltrue([(input2["body"]["contentType"] == null ? true : alltrue([(input2["body"]["contentType"] == null ? true : contains(["text", "html"], input2["body"]["contentType"]))]))])), (input2["importance"] == null ? true : alltrue([(input2["importance"] == null ? true : contains(["low", "normal", "high"], input2["importance"]))])), (input2["onlineMeetingProvider"] == null ? true : alltrue([(input2["onlineMeetingProvider"] == null ? true : contains(["unknown", "skypeForBusiness", "skypeForConsumer", "teamsForBusiness"], input2["onlineMeetingProvider"]))])), (input2["responseStatus"] == null ? true : alltrue([(input2["responseStatus"]["response"] == null ? true : alltrue([(input2["responseStatus"]["response"] == null ? true : contains(["none", "organizer", "tentativelyAccepted", "accepted", "declined", "notResponded"], input2["responseStatus"]["response"]))]))])), (input2["sensitivity"] == null ? true : alltrue([(input2["sensitivity"] == null ? true : contains(["normal", "personal", "private", "confidential"], input2["sensitivity"]))])), (input2["showAs"] == null ? true : alltrue([(input2["showAs"] == null ? true : contains(["unknown", "free", "tentative", "busy", "oof", "workingElsewhere"], input2["showAs"]))]))]))])])), (input0["sites"] == null ? true : alltrue([alltrue([for input2 in input0["sites"] : (input2 == null ? true : alltrue([(input2["lockState"] == null ? true : alltrue([(input2["lockState"] == null ? true : contains(["unlocked", "lockedReadOnly", "lockedNoAccess", "lockedNoAdditions"], input2["lockState"]))])), (input2["template"] == null ? true : alltrue([(input2["template"] == null ? true : contains(["sitepagepublishing", "sts"], input2["template"]))]))]))])]))]))])]))
    error_message = "allowed_groups: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "allowed_users" {
  description = "The users who have access to print using the printer."
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
    condition     = (var.allowed_users == null ? true : alltrue([alltrue([for input0 in var.allowed_users : (input0 == null ? true : alltrue([(input0["chats"] == null ? true : alltrue([alltrue([for input2 in input0["chats"] : (input2 == null ? true : alltrue([(input2["chatType"] == null ? true : alltrue([(input2["chatType"] == null ? true : contains(["oneOnOne", "group", "meeting"], input2["chatType"]))])), (input2["migrationMode"] == null ? true : alltrue([(input2["migrationMode"] == null ? true : contains(["inProgress", "completed"], input2["migrationMode"]))]))]))])])), (input0["followedSites"] == null ? true : alltrue([alltrue([for input2 in input0["followedSites"] : (input2 == null ? true : alltrue([(input2["lockState"] == null ? true : alltrue([(input2["lockState"] == null ? true : contains(["unlocked", "lockedReadOnly", "lockedNoAccess", "lockedNoAdditions"], input2["lockState"]))])), (input2["template"] == null ? true : alltrue([(input2["template"] == null ? true : contains(["sitepagepublishing", "sts"], input2["template"]))]))]))])])), (input0["joinedGroups"] == null ? true : alltrue([alltrue([for input2 in input0["joinedGroups"] : (input2 == null ? true : alltrue([(input2["accessType"] == null ? true : alltrue([(input2["accessType"] == null ? true : contains(["none", "private", "secret", "public"], input2["accessType"]))]))]))])])), (input0["mailboxSettings"] == null ? true : alltrue([(input0["mailboxSettings"]["automaticRepliesSetting"] == null ? true : alltrue([(input0["mailboxSettings"]["automaticRepliesSetting"]["externalAudience"] == null ? true : alltrue([(input0["mailboxSettings"]["automaticRepliesSetting"]["externalAudience"] == null ? true : contains(["none", "contactsOnly", "all"], input0["mailboxSettings"]["automaticRepliesSetting"]["externalAudience"]))])), (input0["mailboxSettings"]["automaticRepliesSetting"]["status"] == null ? true : alltrue([(input0["mailboxSettings"]["automaticRepliesSetting"]["status"] == null ? true : contains(["disabled", "alwaysEnabled", "scheduled"], input0["mailboxSettings"]["automaticRepliesSetting"]["status"]))]))])), (input0["mailboxSettings"]["delegateMeetingMessageDeliveryOptions"] == null ? true : alltrue([(input0["mailboxSettings"]["delegateMeetingMessageDeliveryOptions"] == null ? true : contains(["sendToDelegateAndInformationToPrincipal", "sendToDelegateAndPrincipal", "sendToDelegateOnly"], input0["mailboxSettings"]["delegateMeetingMessageDeliveryOptions"]))])), (input0["mailboxSettings"]["userPurposeV2"] == null ? true : alltrue([(input0["mailboxSettings"]["userPurposeV2"] == null ? true : contains(["unknown", "user", "linked", "shared", "room", "equipment", "others"], input0["mailboxSettings"]["userPurposeV2"]))])), (input0["mailboxSettings"]["workingHours"] == null ? true : alltrue([(input0["mailboxSettings"]["workingHours"]["daysOfWeek"] == null ? true : alltrue([alltrue([for input4 in input0["mailboxSettings"]["workingHours"]["daysOfWeek"] : (input4 == null ? true : alltrue([(input4 == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input4))]))])]))]))])), (input0["managedAppLogCollectionRequests"] == null ? true : alltrue([alltrue([for input2 in input0["managedAppLogCollectionRequests"] : (input2 == null ? true : alltrue([(input2["userLogUploadConsent"] == null ? true : alltrue([(input2["userLogUploadConsent"] == null ? true : contains(["unknown", "declined", "accepted"], input2["userLogUploadConsent"]))]))]))])])), (input0["managedDevices"] == null ? true : alltrue([alltrue([for input2 in input0["managedDevices"] : (input2 == null ? true : alltrue([(input2["configurationManagerClientHealthState"] == null ? true : alltrue([(input2["configurationManagerClientHealthState"]["state"] == null ? true : alltrue([(input2["configurationManagerClientHealthState"]["state"] == null ? true : contains(["unknown", "installed", "healthy", "installFailed", "updateFailed", "communicationError"], input2["configurationManagerClientHealthState"]["state"]))]))])), (input2["joinType"] == null ? true : alltrue([(input2["joinType"] == null ? true : contains(["unknown", "azureADJoined", "azureADRegistered", "hybridAzureADJoined"], input2["joinType"]))])), (input2["managedDeviceOwnerType"] == null ? true : alltrue([(input2["managedDeviceOwnerType"] == null ? true : contains(["unknown", "company", "personal"], input2["managedDeviceOwnerType"]))])), (input2["managementFeatures"] == null ? true : alltrue([(input2["managementFeatures"] == null ? true : contains(["none", "microsoftManagedDesktop"], input2["managementFeatures"]))])), (input2["ownerType"] == null ? true : alltrue([(input2["ownerType"] == null ? true : contains(["unknown", "company", "personal"], input2["ownerType"]))]))]))])])), (input0["notifications"] == null ? true : alltrue([alltrue([for input2 in input0["notifications"] : (input2 == null ? true : alltrue([(input2["priority"] == null ? true : alltrue([(input2["priority"] == null ? true : contains(["None", "High", "Low"], input2["priority"]))]))]))])])), (input0["onlineMeetings"] == null ? true : alltrue([alltrue([for input2 in input0["onlineMeetings"] : (input2 == null ? true : alltrue([(input2["allowLiveShare"] == null ? true : alltrue([(input2["allowLiveShare"] == null ? true : contains(["enabled", "disabled"], input2["allowLiveShare"]))])), (input2["allowMeetingChat"] == null ? true : alltrue([(input2["allowMeetingChat"] == null ? true : contains(["enabled", "disabled", "limited"], input2["allowMeetingChat"]))])), (input2["allowedLobbyAdmitters"] == null ? true : alltrue([(input2["allowedLobbyAdmitters"] == null ? true : contains(["organizerAndCoOrganizersAndPresenters", "organizerAndCoOrganizers"], input2["allowedLobbyAdmitters"]))])), (input2["allowedPresenters"] == null ? true : alltrue([(input2["allowedPresenters"] == null ? true : contains(["everyone", "organization", "roleIsPresenter", "organizer"], input2["allowedPresenters"]))])), (input2["anonymizeIdentityForRoles"] == null ? true : alltrue([alltrue([for input4 in input2["anonymizeIdentityForRoles"] : (input4 == null ? true : alltrue([(input4 == null ? true : contains(["attendee", "presenter", "producer"], input4))]))])])), (input2["broadcastSettings"] == null ? true : alltrue([(input2["broadcastSettings"]["allowedAudience"] == null ? true : alltrue([(input2["broadcastSettings"]["allowedAudience"] == null ? true : contains(["roleIsAttendee", "organization", "everyone"], input2["broadcastSettings"]["allowedAudience"]))]))])), (input2["capabilities"] == null ? true : alltrue([alltrue([for input4 in input2["capabilities"] : (input4 == null ? true : alltrue([(input4 == null ? true : contains(["questionAndAnswer"], input4))]))])])), (input2["lobbyBypassSettings"] == null ? true : alltrue([(input2["lobbyBypassSettings"]["scope"] == null ? true : alltrue([(input2["lobbyBypassSettings"]["scope"] == null ? true : contains(["organizer", "organization", "organizationAndFederated", "everyone"], input2["lobbyBypassSettings"]["scope"]))]))])), (input2["shareMeetingChatHistoryDefault"] == null ? true : alltrue([(input2["shareMeetingChatHistoryDefault"] == null ? true : contains(["none", "all"], input2["shareMeetingChatHistoryDefault"]))]))]))])])), (input0["usageRights"] == null ? true : alltrue([alltrue([for input2 in input0["usageRights"] : (input2 == null ? true : alltrue([(input2["state"] == null ? true : alltrue([(input2["state"] == null ? true : contains(["active", "inactive", "warning", "suspended"], input2["state"]))]))]))])]))]))])]))
    error_message = "allowed_users: nested required attributes must be non-null and enum values must be supported input members."
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
      maximum    = optional(number)
      minimum    = optional(number)
      start      = optional(number)
    }))
    dpis                         = optional(list(number))
    duplexModes                  = optional(list(string))
    feedDirections               = optional(list(string))
    feedOrientations             = optional(list(string))
    finishings                   = optional(list(string))
    inputBins                    = optional(list(string))
    isPageRangeSupported         = optional(bool)
    leftMargins                  = optional(list(number))
    mediaColors                  = optional(list(string))
    mediaSizes                   = optional(list(string))
    mediaTypes                   = optional(list(string))
    multipageLayouts             = optional(list(string))
    orientations                 = optional(list(string))
    outputBins                   = optional(list(string))
    pagesPerSheet                = optional(list(number))
    qualities                    = optional(list(string))
    rightMargins                 = optional(list(number))
    scalings                     = optional(list(string))
    supportedColorConfigurations = optional(list(string))
    supportedCopiesPerJob = optional(object({
      odata_type = optional(string, "#microsoft.graph.integerRange")
      end        = optional(number)
      maximum    = optional(number)
      minimum    = optional(number)
      start      = optional(number)
    }))
    supportedDocumentMimeTypes    = optional(list(string))
    supportedDuplexConfigurations = optional(list(string))
    supportedFinishings           = optional(list(string))
    supportedMediaColors          = optional(list(string))
    supportedMediaSizes           = optional(list(string))
    supportedMediaTypes           = optional(list(string))
    supportedOrientations         = optional(list(string))
    supportedOutputBins           = optional(list(string))
    supportedPagesPerSheet = optional(object({
      odata_type = optional(string, "#microsoft.graph.integerRange")
      end        = optional(number)
      maximum    = optional(number)
      minimum    = optional(number)
      start      = optional(number)
    }))
    supportedPresentationDirections = optional(list(string))
    supportedPrintQualities         = optional(list(string))
    supportsFitPdfToPage            = optional(bool)
    topMargins                      = optional(list(number))
  })
  default = null

  validation {
    condition     = (var.capabilities == null ? true : alltrue([(var.capabilities["colorModes"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["colorModes"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["blackAndWhite", "grayscale", "color", "auto"], input1))]))])])), (var.capabilities["duplexModes"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["duplexModes"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["flipOnLongEdge", "flipOnShortEdge", "oneSided"], input1))]))])])), (var.capabilities["feedDirections"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["feedDirections"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["longEdgeFirst", "shortEdgeFirst"], input1))]))])])), (var.capabilities["feedOrientations"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["feedOrientations"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["longEdgeFirst", "shortEdgeFirst"], input1))]))])])), (var.capabilities["finishings"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["finishings"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["none", "staple", "punch", "cover", "bind", "saddleStitch", "stitchEdge", "stapleTopLeft", "stapleBottomLeft", "stapleTopRight", "stapleBottomRight", "stitchLeftEdge", "stitchTopEdge", "stitchRightEdge", "stitchBottomEdge", "stapleDualLeft", "stapleDualTop", "stapleDualRight", "stapleDualBottom"], input1))]))])])), (var.capabilities["multipageLayouts"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["multipageLayouts"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["clockwiseFromTopLeft", "counterclockwiseFromTopLeft", "counterclockwiseFromTopRight", "clockwiseFromTopRight", "counterclockwiseFromBottomLeft", "clockwiseFromBottomLeft", "counterclockwiseFromBottomRight", "clockwiseFromBottomRight"], input1))]))])])), (var.capabilities["orientations"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["orientations"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["portrait", "landscape", "reverseLandscape", "reversePortrait"], input1))]))])])), (var.capabilities["qualities"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["qualities"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["low", "medium", "high"], input1))]))])])), (var.capabilities["scalings"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["scalings"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["auto", "shrinkToFit", "fill", "fit", "none"], input1))]))])])), (var.capabilities["supportedColorConfigurations"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["supportedColorConfigurations"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["blackAndWhite", "grayscale", "color", "auto"], input1))]))])])), (var.capabilities["supportedDuplexConfigurations"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["supportedDuplexConfigurations"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["twoSidedLongEdge", "twoSidedShortEdge", "oneSided"], input1))]))])])), (var.capabilities["supportedFinishings"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["supportedFinishings"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["none", "staple", "punch", "cover", "bind", "saddleStitch", "stitchEdge", "stapleTopLeft", "stapleBottomLeft", "stapleTopRight", "stapleBottomRight", "stitchLeftEdge", "stitchTopEdge", "stitchRightEdge", "stitchBottomEdge", "stapleDualLeft", "stapleDualTop", "stapleDualRight", "stapleDualBottom"], input1))]))])])), (var.capabilities["supportedMediaTypes"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["supportedMediaTypes"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["stationery", "transparency", "envelope", "envelopePlain", "continuous", "screen", "screenPaged", "continuousLong", "continuousShort", "envelopeWindow", "multiPartForm", "multiLayer", "labels"], input1))]))])])), (var.capabilities["supportedOrientations"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["supportedOrientations"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["portrait", "landscape", "reverseLandscape", "reversePortrait"], input1))]))])])), (var.capabilities["supportedPresentationDirections"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["supportedPresentationDirections"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["clockwiseFromTopLeft", "counterClockwiseFromTopLeft", "counterClockwiseFromTopRight", "clockwiseFromTopRight", "counterClockwiseFromBottomLeft", "clockwiseFromBottomLeft", "counterClockwiseFromBottomRight", "clockwiseFromBottomRight"], input1))]))])])), (var.capabilities["supportedPrintQualities"] == null ? true : alltrue([alltrue([for input1 in var.capabilities["supportedPrintQualities"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["low", "medium", "high"], input1))]))])]))]))
    error_message = "capabilities: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "defaults" {
  description = "The default print settings of printer/printerShare."
  type = object({
    odata_type              = optional(string, "#microsoft.graph.printerDefaults")
    colorMode               = optional(string)
    contentType             = optional(string)
    copiesPerJob            = optional(number)
    documentMimeType        = optional(string)
    dpi                     = optional(number)
    duplexConfiguration     = optional(string)
    duplexMode              = optional(string)
    finishings              = optional(list(string))
    fitPdfToPage            = optional(bool)
    inputBin                = optional(string)
    mediaColor              = optional(string)
    mediaSize               = optional(string)
    mediaType               = optional(string)
    multipageLayout         = optional(string)
    orientation             = optional(string)
    outputBin               = optional(string)
    pagesPerSheet           = optional(number)
    pdfFitToPage            = optional(bool)
    presentationDirection   = optional(string)
    printColorConfiguration = optional(string)
    printQuality            = optional(string)
    quality                 = optional(string)
    scaling                 = optional(string)
  })
  default = null

  validation {
    condition     = (var.defaults == null ? true : alltrue([(var.defaults["colorMode"] == null ? true : alltrue([(var.defaults["colorMode"] == null ? true : contains(["blackAndWhite", "grayscale", "color", "auto"], var.defaults["colorMode"]))])), (var.defaults["duplexConfiguration"] == null ? true : alltrue([(var.defaults["duplexConfiguration"] == null ? true : contains(["twoSidedLongEdge", "twoSidedShortEdge", "oneSided"], var.defaults["duplexConfiguration"]))])), (var.defaults["duplexMode"] == null ? true : alltrue([(var.defaults["duplexMode"] == null ? true : contains(["flipOnLongEdge", "flipOnShortEdge", "oneSided"], var.defaults["duplexMode"]))])), (var.defaults["finishings"] == null ? true : alltrue([alltrue([for input1 in var.defaults["finishings"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["none", "staple", "punch", "cover", "bind", "saddleStitch", "stitchEdge", "stapleTopLeft", "stapleBottomLeft", "stapleTopRight", "stapleBottomRight", "stitchLeftEdge", "stitchTopEdge", "stitchRightEdge", "stitchBottomEdge", "stapleDualLeft", "stapleDualTop", "stapleDualRight", "stapleDualBottom"], input1))]))])])), (var.defaults["multipageLayout"] == null ? true : alltrue([(var.defaults["multipageLayout"] == null ? true : contains(["clockwiseFromTopLeft", "counterclockwiseFromTopLeft", "counterclockwiseFromTopRight", "clockwiseFromTopRight", "counterclockwiseFromBottomLeft", "clockwiseFromBottomLeft", "counterclockwiseFromBottomRight", "clockwiseFromBottomRight"], var.defaults["multipageLayout"]))])), (var.defaults["orientation"] == null ? true : alltrue([(var.defaults["orientation"] == null ? true : contains(["portrait", "landscape", "reverseLandscape", "reversePortrait"], var.defaults["orientation"]))])), (var.defaults["presentationDirection"] == null ? true : alltrue([(var.defaults["presentationDirection"] == null ? true : contains(["clockwiseFromTopLeft", "counterClockwiseFromTopLeft", "counterClockwiseFromTopRight", "clockwiseFromTopRight", "counterClockwiseFromBottomLeft", "clockwiseFromBottomLeft", "counterClockwiseFromBottomRight", "clockwiseFromBottomRight"], var.defaults["presentationDirection"]))])), (var.defaults["printColorConfiguration"] == null ? true : alltrue([(var.defaults["printColorConfiguration"] == null ? true : contains(["blackAndWhite", "grayscale", "color", "auto"], var.defaults["printColorConfiguration"]))])), (var.defaults["printQuality"] == null ? true : alltrue([(var.defaults["printQuality"] == null ? true : contains(["low", "medium", "high"], var.defaults["printQuality"]))])), (var.defaults["quality"] == null ? true : alltrue([(var.defaults["quality"] == null ? true : contains(["low", "medium", "high"], var.defaults["quality"]))])), (var.defaults["scaling"] == null ? true : alltrue([(var.defaults["scaling"] == null ? true : contains(["auto", "shrinkToFit", "fill", "fit", "none"], var.defaults["scaling"]))]))]))
    error_message = "defaults: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "display_name" {
  description = "The name of the printer/printerShare."
  type        = string
  default     = null
}

variable "is_accepting_jobs" {
  description = "Specifies whether the printer/printerShare is currently accepting new print jobs."
  type        = bool
  default     = null
}

variable "jobs" {
  description = "The list of jobs that are queued for printing by the printer/printerShare."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.printJob")
    acknowledgedDateTime = optional(string)
    completedDateTime    = optional(string)
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
    createdBy   = optional(any)
    displayName = optional(string)
    documents = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.printDocument")
      configuration = optional(object({
        odata_type      = optional(string, "#microsoft.graph.printerDocumentConfiguration")
        collate         = optional(bool)
        colorMode       = optional(string)
        copies          = optional(number)
        dpi             = optional(number)
        duplexMode      = optional(string)
        feedDirection   = optional(string)
        feedOrientation = optional(string)
        finishings      = optional(any)
        fitPdfToPage    = optional(bool)
        inputBin        = optional(string)
        margin          = optional(any)
        mediaSize       = optional(string)
        mediaType       = optional(string)
        multipageLayout = optional(string)
        orientation     = optional(string)
        outputBin       = optional(string)
        pageRanges      = optional(any)
        pagesPerSheet   = optional(number)
        quality         = optional(string)
        scaling         = optional(string)
      }))
      downloadedDateTime = optional(string)
      uploadedDateTime   = optional(string)
    })))
    errorCode      = optional(number)
    isFetchable    = optional(bool)
    redirectedFrom = optional(string)
    redirectedTo   = optional(string)
    status = optional(object({
      odata_type                 = optional(string, "#microsoft.graph.printJobStatus")
      acquiredByPrinter          = optional(bool)
      processingState            = optional(string)
      processingStateDescription = optional(string)
      state                      = optional(string)
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
    condition     = (var.jobs == null ? true : alltrue([alltrue([for input0 in var.jobs : (input0 == null ? true : alltrue([(input0["configuration"] == null ? true : alltrue([(input0["configuration"]["finishings"] == null ? true : alltrue([alltrue([for input3 in input0["configuration"]["finishings"] : (input3 == null ? true : alltrue([(input3 == null ? true : contains(["none", "staple", "punch", "cover", "bind", "saddleStitch", "stitchEdge", "stapleTopLeft", "stapleBottomLeft", "stapleTopRight", "stapleBottomRight", "stitchLeftEdge", "stitchTopEdge", "stitchRightEdge", "stitchBottomEdge", "stapleDualLeft", "stapleDualTop", "stapleDualRight", "stapleDualBottom"], input3))]))])])), (input0["configuration"]["multipageLayout"] == null ? true : alltrue([(input0["configuration"]["multipageLayout"] == null ? true : contains(["clockwiseFromTopLeft", "counterclockwiseFromTopLeft", "counterclockwiseFromTopRight", "clockwiseFromTopRight", "counterclockwiseFromBottomLeft", "clockwiseFromBottomLeft", "counterclockwiseFromBottomRight", "clockwiseFromBottomRight"], input0["configuration"]["multipageLayout"]))])), (input0["configuration"]["orientation"] == null ? true : alltrue([(input0["configuration"]["orientation"] == null ? true : contains(["portrait", "landscape", "reverseLandscape", "reversePortrait"], input0["configuration"]["orientation"]))])), (input0["configuration"]["scaling"] == null ? true : alltrue([(input0["configuration"]["scaling"] == null ? true : contains(["auto", "shrinkToFit", "fill", "fit", "none"], input0["configuration"]["scaling"]))]))])), (input0["documents"] == null ? true : alltrue([alltrue([for input2 in input0["documents"] : (input2 == null ? true : alltrue([(input2["configuration"] == null ? true : alltrue([(input2["configuration"]["colorMode"] == null ? true : alltrue([(input2["configuration"]["colorMode"] == null ? true : contains(["blackAndWhite", "grayscale", "color", "auto"], input2["configuration"]["colorMode"]))])), (input2["configuration"]["duplexMode"] == null ? true : alltrue([(input2["configuration"]["duplexMode"] == null ? true : contains(["flipOnLongEdge", "flipOnShortEdge", "oneSided"], input2["configuration"]["duplexMode"]))])), (input2["configuration"]["feedDirection"] == null ? true : alltrue([(input2["configuration"]["feedDirection"] == null ? true : contains(["longEdgeFirst", "shortEdgeFirst"], input2["configuration"]["feedDirection"]))])), (input2["configuration"]["feedOrientation"] == null ? true : alltrue([(input2["configuration"]["feedOrientation"] == null ? true : contains(["longEdgeFirst", "shortEdgeFirst"], input2["configuration"]["feedOrientation"]))])), (input2["configuration"]["multipageLayout"] == null ? true : alltrue([(input2["configuration"]["multipageLayout"] == null ? true : contains(["clockwiseFromTopLeft", "counterclockwiseFromTopLeft", "counterclockwiseFromTopRight", "clockwiseFromTopRight", "counterclockwiseFromBottomLeft", "clockwiseFromBottomLeft", "counterclockwiseFromBottomRight", "clockwiseFromBottomRight"], input2["configuration"]["multipageLayout"]))])), (input2["configuration"]["orientation"] == null ? true : alltrue([(input2["configuration"]["orientation"] == null ? true : contains(["portrait", "landscape", "reverseLandscape", "reversePortrait"], input2["configuration"]["orientation"]))])), (input2["configuration"]["quality"] == null ? true : alltrue([(input2["configuration"]["quality"] == null ? true : contains(["low", "medium", "high"], input2["configuration"]["quality"]))])), (input2["configuration"]["scaling"] == null ? true : alltrue([(input2["configuration"]["scaling"] == null ? true : contains(["auto", "shrinkToFit", "fill", "fit", "none"], input2["configuration"]["scaling"]))]))]))]))])])), (input0["status"] == null ? true : alltrue([(input0["status"]["processingState"] == null ? true : alltrue([(input0["status"]["processingState"] == null ? true : contains(["unknown", "pending", "processing", "paused", "stopped", "completed", "canceled", "aborted"], input0["status"]["processingState"]))])), (input0["status"]["state"] == null ? true : alltrue([(input0["status"]["state"] == null ? true : contains(["unknown", "pending", "processing", "paused", "stopped", "completed", "canceled", "aborted"], input0["status"]["state"]))]))])), (input0["tasks"] == null ? true : alltrue([alltrue([for input2 in input0["tasks"] : (input2 == null ? true : alltrue([(input2["status"] == null ? true : alltrue([(input2["status"]["state"] == null ? true : alltrue([(input2["status"]["state"] == null ? true : contains(["pending", "processing", "completed", "aborted"], input2["status"]["state"]))]))])), (input2["trigger"] == null ? true : alltrue([(input2["trigger"]["event"] == null ? true : alltrue([(input2["trigger"]["event"] == null ? true : contains(["jobStarted"], input2["trigger"]["event"]))]))]))]))])]))]))])]))
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
    floorNumber      = optional(number)
    latitude         = optional(any)
    longitude        = optional(any)
    organization     = optional(list(string))
    postalCode       = optional(string)
    roomDescription  = optional(string)
    roomName         = optional(string)
    roomNumber       = optional(number)
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

variable "name" {
  description = "Microsoft Graph name property."
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
    odata_type                 = optional(string, "#microsoft.graph.printerStatus")
    processingState            = optional(string)
    processingStateDescription = optional(string)
    processingStateReasons     = optional(list(string))
    state                      = optional(string)
  })
  default = null

  validation {
    condition     = (var.status == null ? true : alltrue([(var.status["processingState"] == null ? true : alltrue([(var.status["processingState"] == null ? true : contains(["unknown", "idle", "processing", "stopped"], var.status["processingState"]))])), (var.status["processingStateReasons"] == null ? true : alltrue([alltrue([for input1 in var.status["processingStateReasons"] : (input1 == null ? true : alltrue([(input1 == null ? true : contains(["paused", "mediaJam", "mediaNeeded", "mediaLow", "mediaEmpty", "coverOpen", "interlockOpen", "outputTrayMissing", "outputAreaFull", "markerSupplyLow", "markerSupplyEmpty", "inputTrayMissing", "outputAreaAlmostFull", "markerWasteAlmostFull", "markerWasteFull", "fuserOverTemp", "fuserUnderTemp", "other", "none", "movingToPaused", "shutdown", "connectingToDevice", "timedOut", "stopping", "stoppedPartially", "tonerLow", "tonerEmpty", "spoolAreaFull", "doorOpen", "opticalPhotoConductorNearEndOfLife", "opticalPhotoConductorLifeOver", "developerLow", "developerEmpty", "interpreterResourceUnavailable"], input1))]))])])), (var.status["state"] == null ? true : alltrue([(var.status["state"] == null ? true : contains(["unknown", "idle", "processing", "stopped"], var.status["state"]))]))]))
    error_message = "status: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "view_point" {
  description = "More data for a printer share as viewed by the signed-in user."
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
