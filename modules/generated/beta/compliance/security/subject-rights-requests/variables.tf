variable "approvers" {
  description = "Microsoft Graph approvers property."
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

variable "assigned_to" {
  description = "Identity that the request is assigned to."
  type        = any
  default     = null
}

variable "closed_date_time" {
  description = "The date and time when the request was closed. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "collaborators" {
  description = "Microsoft Graph collaborators property."
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
  description = "The date and time when the request was created. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "data_subject" {
  description = "Information about the data subject."
  type        = any
  default     = null
}

variable "data_subject_type" {
  description = "The type of the data subject. The possible values are: customer, currentEmployee, formerEmployee, prospectiveEmployee, student, teacher, faculty, other, unknownFutureValue."
  type        = any
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
    stage         = optional(any)
    stageStatus   = optional(any)
    type          = optional(string)
  }))
  default = null
}

variable "include_all_versions" {
  description = "Include all versions of the documents. By default, the current copies of the documents will be returned. If SharePoint sites have versioning enabled, including all versions include the historical copies of the documents. This property is defined only for APIs accessed using the /security query path and not the /privacy query path."
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
  type        = any
  default     = null
}

variable "internal_due_date_time" {
  description = "The date and time when the request is internally due. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "Identity information for the entity that last modified the request."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the request was last modified. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
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
    odata_type      = optional(string, "#microsoft.graph.authoredNote")
    author          = optional(any)
    content         = optional(any)
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
  description = "List of regulations that this request fulfills."
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
    error      = optional(any)
    stage      = optional(any)
    status     = optional(any)
  }))
  default = null
}

variable "status" {
  description = "The status of the request. The possible values are: active, closed, unknownFutureValue."
  type        = any
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
  type        = any
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
