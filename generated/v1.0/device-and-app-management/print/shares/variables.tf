variable "allow_all_users" {
  description = "If true, all users and groups will be granted access to this printer share. This supersedes the allow lists defined by the allowedUsers and allowedGroups navigation properties."
  type        = bool
  default     = null
}

variable "allowed_groups" {
  description = "The groups whose users have access to print using the printer."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.group")
    acceptedSenders = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    accessType           = optional(any)
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
      odata_type                 = optional(string, "#microsoft.graph.event")
      allowNewTimeProposals      = optional(bool)
      attendees                  = optional(any)
      body                       = optional(any)
      bodyPreview                = optional(string)
      cancelledOccurrences       = optional(list(string))
      categories                 = optional(list(string))
      createdDateTime            = optional(string)
      end                        = optional(any)
      exceptionOccurrences       = optional(any)
      extensions                 = optional(any)
      hasAttachments             = optional(bool)
      hideAttendees              = optional(bool)
      importance                 = optional(any)
      isAllDay                   = optional(bool)
      isCancelled                = optional(bool)
      isDraft                    = optional(bool)
      isOnlineMeeting            = optional(bool)
      isOrganizer                = optional(bool)
      isReminderOn               = optional(bool)
      lastModifiedDateTime       = optional(string)
      location                   = optional(any)
      locations                  = optional(any)
      onlineMeetingProvider      = optional(any)
      organizer                  = optional(any)
      originalEndTimeZone        = optional(string)
      originalStart              = optional(string)
      originalStartTimeZone      = optional(string)
      recurrence                 = optional(any)
      reminderMinutesBeforeStart = optional(number)
      responseRequested          = optional(bool)
      responseStatus             = optional(any)
      sensitivity                = optional(any)
      seriesMasterId             = optional(string)
      showAs                     = optional(any)
      start                      = optional(any)
      subject                    = optional(string)
      transactionId              = optional(string)
      webLink                    = optional(string)
    })))
    groupTypes                  = optional(list(string))
    hasMembersWithLicenseErrors = optional(bool)
    hideFromAddressLists        = optional(bool)
    hideFromOutlookClients      = optional(bool)
    infoCatalogs                = optional(list(string))
    isAssignableToRole          = optional(bool)
    isFavorite                  = optional(bool)
    isSubscribedByMail          = optional(bool)
    mailEnabled                 = optional(bool)
    mailNickname                = optional(string)
    members = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    membershipRule                = optional(string)
    membershipRuleProcessingState = optional(string)
    onPremisesExtensionAttributes = optional(any)
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
    owners = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    permissionGrants = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
      deletedDateTime = optional(string)
    })))
    photo                 = optional(any)
    planner               = optional(any)
    preferredDataLocation = optional(string)
    preferredLanguage     = optional(string)
    rejectedSenders = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    resourceBehaviorOptions     = optional(list(string))
    resourceProvisioningOptions = optional(list(string))
    securityEnabled             = optional(bool)
    serviceProvisioningErrors = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.serviceProvisioningError")
      createdDateTime = optional(string)
      isResolved      = optional(bool)
      serviceInstance = optional(string)
    })))
    settings = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.groupSetting")
      displayName = optional(string)
      values      = optional(any)
    })))
    sites = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.site")
      analytics       = optional(any)
      columns         = optional(any)
      contentTypes    = optional(any)
      description     = optional(string)
      drive           = optional(any)
      drives          = optional(any)
      error           = optional(any)
      externalColumns = optional(any)
      items           = optional(any)
      lists           = optional(any)
      name            = optional(string)
      onenote         = optional(any)
      operations      = optional(any)
      pages           = optional(any)
      parentReference = optional(any)
      permissions     = optional(any)
      sites           = optional(any)
      termStore       = optional(any)
      termStores      = optional(any)
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
    transitiveMemberOf = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    transitiveMembers = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    unseenConversationsCount = optional(number)
    unseenCount              = optional(number)
    unseenMessagesCount      = optional(number)
    visibility               = optional(string)
    welcomeMessageEnabled    = optional(bool)
  }))
  default = null
}

variable "allowed_users" {
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
    authentication    = optional(any)
    authorizationInfo = optional(any)
    birthday          = optional(string)
    chats = optional(list(object({
      odata_type              = optional(string, "#microsoft.graph.chat")
      chatType                = optional(string)
      installedApps           = optional(any)
      lastMessagePreview      = optional(any)
      members                 = optional(any)
      messages                = optional(any)
      migrationMode           = optional(any)
      originalCreatedDateTime = optional(string)
      permissionGrants        = optional(any)
      pinnedMessages          = optional(any)
      tabs                    = optional(any)
      targetedMessages        = optional(any)
      topic                   = optional(string)
      viewpoint               = optional(any)
    })))
    city                     = optional(string)
    cloudClipboard           = optional(any)
    companyName              = optional(string)
    consentProvidedForMinor  = optional(string)
    country                  = optional(string)
    customSecurityAttributes = optional(any)
    deletedDateTime          = optional(string)
    department               = optional(string)
    deviceEnrollmentLimit    = optional(number)
    deviceManagementTroubleshootingEvents = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.deviceManagementTroubleshootingEvent")
      correlationId = optional(string)
      eventDateTime = optional(string)
    })))
    displayName                     = optional(string)
    employeeExperience              = optional(any)
    employeeHireDate                = optional(string)
    employeeId                      = optional(string)
    employeeLeaveDateTime           = optional(string)
    employeeOrgData                 = optional(any)
    employeeType                    = optional(string)
    externalUserState               = optional(string)
    externalUserStateChangeDateTime = optional(string)
    faxNumber                       = optional(string)
    followedSites = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.site")
      analytics       = optional(any)
      columns         = optional(any)
      contentTypes    = optional(any)
      description     = optional(string)
      drive           = optional(any)
      drives          = optional(any)
      error           = optional(any)
      externalColumns = optional(any)
      items           = optional(any)
      lists           = optional(any)
      name            = optional(string)
      onenote         = optional(any)
      operations      = optional(any)
      pages           = optional(any)
      parentReference = optional(any)
      permissions     = optional(any)
      sites           = optional(any)
      termStore       = optional(any)
      termStores      = optional(any)
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
      odata_type        = optional(string, "#microsoft.graph.team")
      allChannels       = optional(any)
      channels          = optional(any)
      classification    = optional(string)
      createdDateTime   = optional(string)
      description       = optional(string)
      displayName       = optional(string)
      firstChannelName  = optional(string)
      funSettings       = optional(any)
      group             = optional(any)
      guestSettings     = optional(any)
      incomingChannels  = optional(any)
      installedApps     = optional(any)
      internalId        = optional(string)
      memberSettings    = optional(any)
      members           = optional(any)
      messagingSettings = optional(any)
      operations        = optional(any)
      permissionGrants  = optional(any)
      photo             = optional(any)
      primaryChannel    = optional(any)
      schedule          = optional(any)
      specialization    = optional(any)
      summary           = optional(any)
      tags              = optional(any)
      template          = optional(any)
      tenantId          = optional(string)
      visibility        = optional(any)
      webUrl            = optional(string)
    })))
    lastPasswordChangeDateTime = optional(string)
    mail                       = optional(string)
    mailNickname               = optional(string)
    mailboxSettings            = optional(any)
    managedAppRegistrations = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.managedAppRegistration")
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
      complianceState              = optional(string)
      deviceCategory               = optional(any)
      deviceCompliancePolicyStates = optional(any)
      deviceConfigurationStates    = optional(any)
      deviceEnrollmentType         = optional(string)
      deviceRegistrationState      = optional(string)
      exchangeAccessState          = optional(string)
      exchangeAccessStateReason    = optional(string)
      logCollectionRequests        = optional(any)
      managedDeviceName            = optional(string)
      managedDeviceOwnerType       = optional(string)
      managementAgent              = optional(string)
      managementState              = optional(string)
      notes                        = optional(string)
      partnerReportedThreatState   = optional(string)
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
      allowLiveShare                       = optional(any)
      allowMeetingChat                     = optional(any)
      allowParticipantsToChangeName        = optional(bool)
      allowPowerPointSharing               = optional(bool)
      allowRecording                       = optional(bool)
      allowTeamworkReactions               = optional(bool)
      allowTranscription                   = optional(bool)
      allowWhiteboard                      = optional(bool)
      allowedLobbyAdmitters                = optional(any)
      allowedPresenters                    = optional(any)
      broadcastSettings                    = optional(any)
      chatInfo                             = optional(any)
      chatRestrictions                     = optional(any)
      endDateTime                          = optional(string)
      expiryDateTime                       = optional(string)
      externalId                           = optional(string)
      isBroadcast                          = optional(bool)
      isEndToEndEncryptionEnabled          = optional(bool)
      isEntryExitAnnounced                 = optional(bool)
      joinMeetingIdSettings                = optional(any)
      lobbyBypassSettings                  = optional(any)
      meetingOptionsWebUrl                 = optional(string)
      meetingSpokenLanguageTag             = optional(string)
      meetingTemplateId                    = optional(string)
      participants                         = optional(any)
      recordAutomatically                  = optional(bool)
      sensitivityLabelAssignment           = optional(any)
      shareMeetingChatHistoryDefault       = optional(any)
      startDateTime                        = optional(string)
      subject                              = optional(string)
      watermarkProtection                  = optional(any)
    })))
    otherMails       = optional(list(string))
    outlook          = optional(any)
    passwordPolicies = optional(string)
    passwordProfile  = optional(any)
    pastProjects     = optional(list(string))
    permissionGrants = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
      deletedDateTime = optional(string)
    })))
    postalCode            = optional(string)
    preferredDataLocation = optional(string)
    preferredLanguage     = optional(string)
    preferredName         = optional(string)
    presence              = optional(any)
    print                 = optional(any)
    responsibilities      = optional(list(string))
    schools               = optional(list(string))
    scopedRoleMemberOf = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.scopedRoleMembership")
      administrativeUnitId = optional(string)
      roleId               = optional(string)
      roleMemberInfo = optional(object({
        odata_type  = optional(string, "#microsoft.graph.identity")
        displayName = optional(string)
        id          = optional(string)
      }))
    })))
    serviceProvisioningErrors = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.serviceProvisioningError")
      createdDateTime = optional(string)
      isResolved      = optional(bool)
      serviceInstance = optional(string)
    })))
    settings          = optional(any)
    showInAddressList = optional(bool)
    skills            = optional(list(string))
    sponsors = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    state         = optional(string)
    streetAddress = optional(string)
    surname       = optional(string)
    todo          = optional(any)
    transitiveMemberOf = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    usageLocation     = optional(string)
    userPrincipalName = optional(string)
    userType          = optional(string)
  }))
  default   = null
  sensitive = true
}

variable "capabilities" {
  description = "The capabilities of the printer/printerShare."
  type        = any
  default     = null
}

variable "defaults" {
  description = "The default print settings of printer/printerShare."
  type        = any
  default     = null
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
    odata_type = optional(string, "#microsoft.graph.printJob")
    configuration = optional(object({
      odata_type      = optional(string, "#microsoft.graph.printJobConfiguration")
      collate         = optional(bool)
      finishings      = optional(any)
      fitPdfToPage    = optional(bool)
      inputBin        = optional(string)
      margin          = optional(any)
      mediaSize       = optional(string)
      mediaType       = optional(string)
      multipageLayout = optional(any)
      orientation     = optional(any)
      outputBin       = optional(string)
      pagesPerSheet   = optional(number)
      scaling         = optional(any)
    }))
    createdBy = optional(any)
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
}

variable "location" {
  description = "The physical and/or organizational location of the printer/printerShare."
  type        = any
  default     = null
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
}

variable "view_point" {
  description = "Additional data for a printer share as viewed by the signed-in user."
  type        = any
  default     = null
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
