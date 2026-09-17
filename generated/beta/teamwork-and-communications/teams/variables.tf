variable "all_channels" {
  description = "List of channels either hosted in or shared with the team (incoming channels)."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.channel")
    allMembers = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.conversationMember")
      displayName                 = optional(string)
      roles                       = optional(list(string))
      visibleHistoryStartDateTime = optional(string)
    })))
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
    joinedUsers = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.conversationMember")
      displayName                 = optional(string)
      roles                       = optional(list(string))
      visibleHistoryStartDateTime = optional(string)
    })))
    layoutType = optional(any)
    members = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.conversationMember")
      displayName                 = optional(string)
      roles                       = optional(list(string))
      visibleHistoryStartDateTime = optional(string)
    })))
    membershipType = optional(any)
    messages = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.chatMessage")
      attachments = optional(any)
      body = optional(object({
        odata_type             = optional(string, "#microsoft.graph.chatMessageBody")
        content                = optional(string)
        contentType            = optional(any)
        messageBodyContentType = optional(any)
      }))
      channelIdentity = optional(any)
      chatId          = optional(string)
      createdDateTime = optional(string)
      from            = optional(any)
      hasReplies      = optional(bool)
      hostedContents  = optional(any)
      importance      = optional(string)
      locale          = optional(string)
      mentions        = optional(any)
      messageHistory  = optional(any)
      messageType     = optional(string)
      onBehalfOf      = optional(any)
      policyViolation = optional(any)
      reactions       = optional(any)
      replies         = optional(any)
      subject         = optional(string)
      summary         = optional(string)
    })))
    migrationMode           = optional(any)
    moderationSettings      = optional(any)
    originalCreatedDateTime = optional(string)
    sharedWithTeams = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")
      allowedMembers = optional(any)
      displayName    = optional(string)
      isHostTeam     = optional(bool)
      team           = optional(any)
      tenantId       = optional(string)
    })))
    summary = optional(any)
    tabs = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.teamsTab")
      configuration  = optional(any)
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
    odata_type = optional(string, "#microsoft.graph.channel")
    allMembers = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.conversationMember")
      displayName                 = optional(string)
      roles                       = optional(list(string))
      visibleHistoryStartDateTime = optional(string)
    })))
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
    joinedUsers = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.conversationMember")
      displayName                 = optional(string)
      roles                       = optional(list(string))
      visibleHistoryStartDateTime = optional(string)
    })))
    layoutType = optional(any)
    members = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.conversationMember")
      displayName                 = optional(string)
      roles                       = optional(list(string))
      visibleHistoryStartDateTime = optional(string)
    })))
    membershipType = optional(any)
    messages = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.chatMessage")
      attachments = optional(any)
      body = optional(object({
        odata_type             = optional(string, "#microsoft.graph.chatMessageBody")
        content                = optional(string)
        contentType            = optional(any)
        messageBodyContentType = optional(any)
      }))
      channelIdentity = optional(any)
      chatId          = optional(string)
      createdDateTime = optional(string)
      from            = optional(any)
      hasReplies      = optional(bool)
      hostedContents  = optional(any)
      importance      = optional(string)
      locale          = optional(string)
      mentions        = optional(any)
      messageHistory  = optional(any)
      messageType     = optional(string)
      onBehalfOf      = optional(any)
      policyViolation = optional(any)
      reactions       = optional(any)
      replies         = optional(any)
      subject         = optional(string)
      summary         = optional(string)
    })))
    migrationMode           = optional(any)
    moderationSettings      = optional(any)
    originalCreatedDateTime = optional(string)
    sharedWithTeams = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")
      allowedMembers = optional(any)
      displayName    = optional(string)
      isHostTeam     = optional(bool)
      team           = optional(any)
      tenantId       = optional(string)
    })))
    summary = optional(any)
    tabs = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.teamsTab")
      configuration  = optional(any)
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
  type        = any
  default     = null
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
  type        = any
  default     = null
}

variable "group" {
  description = "Microsoft Graph group property."
  type        = any
  default     = null
}

variable "guest_settings" {
  description = "Settings to configure whether guests can create, update, or delete channels in the team."
  type        = any
  default     = null
}

variable "incoming_channels" {
  description = "List of channels shared with the team."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.channel")
    allMembers = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.conversationMember")
      displayName                 = optional(string)
      roles                       = optional(list(string))
      visibleHistoryStartDateTime = optional(string)
    })))
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
    joinedUsers = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.conversationMember")
      displayName                 = optional(string)
      roles                       = optional(list(string))
      visibleHistoryStartDateTime = optional(string)
    })))
    layoutType = optional(any)
    members = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.conversationMember")
      displayName                 = optional(string)
      roles                       = optional(list(string))
      visibleHistoryStartDateTime = optional(string)
    })))
    membershipType = optional(any)
    messages = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.chatMessage")
      attachments = optional(any)
      body = optional(object({
        odata_type             = optional(string, "#microsoft.graph.chatMessageBody")
        content                = optional(string)
        contentType            = optional(any)
        messageBodyContentType = optional(any)
      }))
      channelIdentity = optional(any)
      chatId          = optional(string)
      createdDateTime = optional(string)
      from            = optional(any)
      hasReplies      = optional(bool)
      hostedContents  = optional(any)
      importance      = optional(string)
      locale          = optional(string)
      mentions        = optional(any)
      messageHistory  = optional(any)
      messageType     = optional(string)
      onBehalfOf      = optional(any)
      policyViolation = optional(any)
      reactions       = optional(any)
      replies         = optional(any)
      subject         = optional(string)
      summary         = optional(string)
    })))
    migrationMode           = optional(any)
    moderationSettings      = optional(any)
    originalCreatedDateTime = optional(string)
    sharedWithTeams = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")
      allowedMembers = optional(any)
      displayName    = optional(string)
      isHostTeam     = optional(bool)
      team           = optional(any)
      tenantId       = optional(string)
    })))
    summary = optional(any)
    tabs = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.teamsTab")
      configuration  = optional(any)
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
  type = list(object({
    odata_type             = optional(string, "#microsoft.graph.teamsAppInstallation")
    consentedPermissionSet = optional(any)
    scopeInfo              = optional(any)
    teamsApp               = optional(any)
    teamsAppDefinition     = optional(any)
  }))
  default = null
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
  type        = any
  default     = null
}

variable "members" {
  description = "Members and owners of the team."
  type = list(object({
    odata_type                  = optional(string, "#microsoft.graph.conversationMember")
    displayName                 = optional(string)
    roles                       = optional(list(string))
    visibleHistoryStartDateTime = optional(string)
  }))
  default = null
}

variable "messaging_settings" {
  description = "Settings to configure messaging and mentions in the team."
  type        = any
  default     = null
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
    odata_type             = optional(string, "#microsoft.graph.teamsAsyncOperation")
    attemptsCount          = optional(number)
    createdDateTime        = optional(string)
    error                  = optional(any)
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
    appRoleAssignedResources = optional(list(object({
      odata_type                          = optional(string, "#microsoft.graph.servicePrincipal")
      accountEnabled                      = optional(bool)
      addIns                              = optional(any)
      alternativeNames                    = optional(list(string))
      appDescription                      = optional(string)
      appDisplayName                      = optional(string)
      appId                               = optional(string)
      appManagementPolicies               = optional(any)
      appOwnerOrganizationId              = optional(string)
      appRoleAssignedTo                   = optional(any)
      appRoleAssignmentRequired           = optional(bool)
      appRoleAssignments                  = optional(any)
      appRoles                            = optional(any)
      claimsMappingPolicies               = optional(any)
      claimsPolicy                        = optional(any)
      customSecurityAttributes            = optional(any)
      delegatedPermissionClassifications  = optional(any)
      deletedDateTime                     = optional(string)
      description                         = optional(string)
      disabledByMicrosoftStatus           = optional(string)
      displayName                         = optional(string)
      endpoints                           = optional(any)
      errorUrl                            = optional(string)
      federatedIdentityCredentials        = optional(any)
      homeRealmDiscoveryPolicies          = optional(any)
      homepage                            = optional(string)
      info                                = optional(any)
      isDisabled                          = optional(bool)
      keyCredentials                      = optional(any)
      licenseDetails                      = optional(any)
      loginUrl                            = optional(string)
      logoutUrl                           = optional(string)
      notes                               = optional(string)
      notificationEmailAddresses          = optional(list(string))
      owners                              = optional(any)
      passwordCredentials                 = optional(any)
      permissionGrantPreApprovalPolicies  = optional(any)
      preferredSingleSignOnMode           = optional(string)
      preferredTokenSigningKeyEndDateTime = optional(string)
      preferredTokenSigningKeyThumbprint  = optional(string)
      publishedPermissionScopes           = optional(any)
      publisherName                       = optional(string)
      remoteDesktopSecurityConfiguration  = optional(any)
      replyUrls                           = optional(list(string))
      samlMetadataUrl                     = optional(string)
      samlSingleSignOnSettings            = optional(any)
      servicePrincipalNames               = optional(list(string))
      servicePrincipalType                = optional(string)
      synchronization                     = optional(any)
      tags                                = optional(list(string))
      tokenEncryptionKeyId                = optional(string)
      tokenIssuancePolicies               = optional(any)
      tokenLifetimePolicies               = optional(any)
      transitiveMemberOf                  = optional(any)
      verifiedPublisher                   = optional(any)
    })))
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
      operations              = optional(any)
      originalCreatedDateTime = optional(string)
      permissionGrants        = optional(any)
      pinnedMessages          = optional(any)
      tabs                    = optional(any)
      targetedMessages        = optional(any)
      topic                   = optional(string)
      viewpoint               = optional(any)
    })))
    city                           = optional(string)
    cloudClipboard                 = optional(any)
    cloudLicensing                 = optional(any)
    cloudRealtimeCommunicationInfo = optional(any)
    communications                 = optional(any)
    companyName                    = optional(string)
    consentProvidedForMinor        = optional(string)
    country                        = optional(string)
    customSecurityAttributes       = optional(any)
    deletedDateTime                = optional(string)
    department                     = optional(string)
    deviceEnrollmentConfigurations = optional(list(object({
      odata_type                        = optional(string, "#microsoft.graph.deviceEnrollmentConfiguration")
      assignments                       = optional(any)
      createdDateTime                   = optional(string)
      description                       = optional(string)
      deviceEnrollmentConfigurationType = optional(string)
      displayName                       = optional(string)
      lastModifiedDateTime              = optional(string)
      priority                          = optional(number)
      roleScopeTagIds                   = optional(list(string))
      version                           = optional(number)
    })))
    deviceEnrollmentLimit = optional(number)
    deviceKeys = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.deviceKey")
      deviceId    = optional(string)
      keyMaterial = optional(string)
      keyType     = optional(string)
    })))
    deviceManagementTroubleshootingEvents = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.deviceManagementTroubleshootingEvent")
      additionalInformation       = optional(any)
      correlationId               = optional(string)
      eventDateTime               = optional(string)
      eventName                   = optional(string)
      troubleshootingErrorDetails = optional(any)
    })))
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
      extensionAttributes    = optional(any)
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
    employeeOrgData       = optional(any)
    employeeType          = optional(string)
    extensions = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.extension")
    })))
    externalUserState               = optional(string)
    externalUserStateChangeDateTime = optional(string)
    faxNumber                       = optional(string)
    followedSites = optional(list(object({
      odata_type             = optional(string, "#microsoft.graph.site")
      analytics              = optional(any)
      columns                = optional(any)
      contentModels          = optional(any)
      contentTypes           = optional(any)
      createdByUser          = optional(any)
      deleted                = optional(any)
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
      lockState              = optional(any)
      name                   = optional(string)
      onenote                = optional(any)
      operations             = optional(any)
      ownerIdentityToResolve = optional(any)
      pageTemplates          = optional(any)
      pages                  = optional(any)
      parentReference        = optional(any)
      permissions            = optional(any)
      recycleBin             = optional(any)
      shareByEmailEnabled    = optional(bool)
      sites                  = optional(any)
      template               = optional(any)
      termStore              = optional(any)
    })))
    givenName = optional(string)
    hireDate  = optional(string)
    identities = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.objectIdentity")
      issuer           = optional(string)
      issuerAssignedId = optional(string)
      signInType       = optional(string)
    })))
    identityGovernance      = optional(any)
    identityParentId        = optional(string)
    inferenceClassification = optional(any)
    infoCatalogs            = optional(list(string))
    informationProtection   = optional(any)
    interests               = optional(list(string))
    invitedBy               = optional(any)
    isResourceAccount       = optional(bool)
    jobTitle                = optional(string)
    joinedGroups = optional(list(object({
      odata_type                    = optional(string, "#microsoft.graph.group")
      acceptedSenders               = optional(any)
      accessType                    = optional(any)
      allowExternalSenders          = optional(bool)
      appRoleAssignments            = optional(any)
      assignedLabels                = optional(any)
      autoSubscribeNewMembers       = optional(bool)
      classification                = optional(string)
      cloudLicensing                = optional(any)
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
      onPremisesExtensionAttributes = optional(any)
      onPremisesProvisioningErrors  = optional(any)
      onPremisesSyncBehavior        = optional(any)
      onenote                       = optional(any)
      organizationId                = optional(string)
      owners                        = optional(any)
      permissionGrants              = optional(any)
      photo                         = optional(any)
      preferredDataLocation         = optional(string)
      preferredLanguage             = optional(string)
      rejectedSenders               = optional(any)
      resourceBehaviorOptions       = optional(list(string))
      resourceProvisioningOptions   = optional(list(string))
      securityEnabled               = optional(bool)
      serviceProvisioningErrors     = optional(any)
      settings                      = optional(any)
      sites                         = optional(any)
      team                          = optional(any)
      theme                         = optional(string)
      threads                       = optional(any)
      transitiveMemberOf            = optional(any)
      transitiveMembers             = optional(any)
      unseenConversationsCount      = optional(number)
      unseenCount                   = optional(number)
      unseenMessagesCount           = optional(number)
      visibility                    = optional(string)
      welcomeMessageEnabled         = optional(bool)
      writebackConfiguration        = optional(any)
    })))
    licenseDetails = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.licenseDetails")
    })))
    mail            = optional(string)
    mailNickname    = optional(string)
    mailboxSettings = optional(any)
    managedAppLogCollectionRequests = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.managedAppLogCollectionRequest")
      userLogUploadConsent = optional(string)
      version              = optional(string)
    })))
    managedAppRegistrations = optional(list(object({
      odata_type                      = optional(string, "#microsoft.graph.managedAppRegistration")
      appIdentifier                   = optional(any)
      applicationVersion              = optional(string)
      appliedPolicies                 = optional(any)
      azureADDeviceId                 = optional(string)
      createdDateTime                 = optional(string)
      deviceManufacturer              = optional(string)
      deviceModel                     = optional(string)
      deviceName                      = optional(string)
      deviceTag                       = optional(string)
      deviceType                      = optional(string)
      flaggedReasons                  = optional(list(string))
      intendedPolicies                = optional(any)
      lastSyncDateTime                = optional(string)
      managedAppLogCollectionRequests = optional(any)
      managedDeviceId                 = optional(string)
      managementSdkVersion            = optional(string)
      operations                      = optional(any)
      platformVersion                 = optional(string)
      userId                          = optional(string)
      version                         = optional(string)
    })))
    managedDevices = optional(list(object({
      odata_type                                  = optional(string, "#microsoft.graph.managedDevice")
      assignmentFilterEvaluationStatusDetails     = optional(any)
      chassisType                                 = optional(string)
      chromeOSDeviceInfo                          = optional(any)
      cloudPcRemoteActionResults                  = optional(any)
      complianceState                             = optional(string)
      configurationManagerClientHealthState       = optional(any)
      configurationManagerClientInformation       = optional(any)
      detectedApps                                = optional(any)
      deviceCategory                              = optional(any)
      deviceCompliancePolicyStates                = optional(any)
      deviceConfigurationStates                   = optional(any)
      deviceEnrollmentType                        = optional(string)
      deviceFirmwareConfigurationInterfaceManaged = optional(bool)
      deviceRegistrationState                     = optional(string)
      deviceType                                  = optional(string)
      exchangeAccessState                         = optional(string)
      exchangeAccessStateReason                   = optional(string)
      joinType                                    = optional(string)
      logCollectionRequests                       = optional(any)
      lostModeState                               = optional(string)
      managedDeviceMobileAppConfigurationStates   = optional(any)
      managedDeviceName                           = optional(string)
      managedDeviceOwnerType                      = optional(string)
      managementAgent                             = optional(string)
      managementFeatures                          = optional(string)
      managementState                             = optional(string)
      notes                                       = optional(string)
      ownerType                                   = optional(string)
      partnerReportedThreatState                  = optional(string)
      processorArchitecture                       = optional(string)
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
      odata_type                  = optional(string, "#microsoft.graph.mobileAppTroubleshootingEvent")
      additionalInformation       = optional(any)
      appLogCollectionRequests    = optional(any)
      applicationId               = optional(string)
      correlationId               = optional(string)
      deviceId                    = optional(string)
      eventDateTime               = optional(string)
      eventName                   = optional(string)
      history                     = optional(any)
      managedDeviceIdentifier     = optional(string)
      troubleshootingErrorDetails = optional(any)
      userId                      = optional(string)
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
      priority       = optional(any)
      targetHostName = optional(string)
      targetPolicy   = optional(any)
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
      anonymizeIdentityForRoles            = optional(any)
      broadcastRecording                   = optional(string)
      broadcastSettings                    = optional(any)
      capabilities                         = optional(any)
      chatInfo                             = optional(any)
      chatRestrictions                     = optional(any)
      endDateTime                          = optional(string)
      expiryDateTime                       = optional(string)
      externalId                           = optional(string)
      isBroadcast                          = optional(bool)
      isEndToEndEncryptionEnabled          = optional(bool)
      isEntryExitAnnounced                 = optional(bool)
      joinMeetingIdSettings                = optional(any)
      joinUrl                              = optional(string)
      lobbyBypassSettings                  = optional(any)
      meetingOptionsWebUrl                 = optional(string)
      meetingSpokenLanguageTag             = optional(string)
      meetingTemplateId                    = optional(string)
      participants                         = optional(any)
      recordAutomatically                  = optional(bool)
      registration                         = optional(any)
      sensitivityLabelAssignment           = optional(any)
      shareMeetingChatHistoryDefault       = optional(any)
      startDateTime                        = optional(string)
      subject                              = optional(string)
      watermarkProtection                  = optional(any)
    })))
    otherMails       = optional(list(string))
    passwordPolicies = optional(string)
    passwordProfile  = optional(any)
    pastProjects     = optional(list(string))
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
    print                 = optional(any)
    profile               = optional(any)
    responsibilities      = optional(list(string))
    schools               = optional(list(string))
    security              = optional(any)
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
    usageLocation = optional(string)
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
  type        = any
  default     = null

  validation {
    condition     = var.specialization == null ? true : contains(["none", "educationStandard", "educationClass", "educationProfessionalLearningCommunity", "educationStaff", "healthcareStandard", "healthcareCareCoordination", "unknownFutureValue"], var.specialization)
    error_message = "specialization must be one of the documented enum values."
  }
}

variable "summary" {
  description = "Contains summary information about the team, including the number of owners, members, and guests."
  type        = any
  default     = null
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
    tagType = optional(any)
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
  type        = any
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
