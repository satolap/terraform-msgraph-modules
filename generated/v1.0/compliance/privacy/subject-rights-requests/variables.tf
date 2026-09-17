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
  type        = any
  default     = null
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
