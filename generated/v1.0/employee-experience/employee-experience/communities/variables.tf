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

variable "group_id" {
  description = "The ID of the Microsoft 365 group that manages the membership of this community."
  type        = string
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
